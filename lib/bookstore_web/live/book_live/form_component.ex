defmodule BookstoreWeb.BookLive.FormComponent do
  use BookstoreWeb, :live_component

  alias Bookstore.Books

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage book records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="book-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:isbn]} type="text" label="Isbn" />
        <.input field={@form[:publication_date]} type="text" label="Publication date" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:quantity]} type="number" label="Quantity" />
        <.input field={@form[:editorial]} type="text" label="Editorial" />
        <.live_file_input upload={@uploads.image } />
        <section phx-drop-target={@uploads.image.ref}>

          <%= for entry <- @uploads.image.entries do %>
            <article class="upload-entry">

              <figure>
                <.live_img_preview entry={entry} />
                <figcaption><%= entry.client_name  %></figcaption>
              </figure>

              <%!-- entry.progress will update automatically for in-flight entries --%>
              <progress value={entry.progress} max="100"> <%= entry.progress %>% </progress>

              <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
              <button type="button" phx-click="cancel-upload" phx-value-ref={entry.ref} aria-label="cancel">&times;</button>

              <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
              <%= for err <- upload_errors(@uploads.image, entry) do %>
                <p class="alert alert-danger"><%= error_to_string(err) %></p>
              <% end %>

            </article>
          <% end %>
          <%!-- Phoenix.Component.upload_errors/1 returns a list of error atoms --%>
          <%= for err <- upload_errors(@uploads.image) do %>
            <p class="alert alert-danger"><%= error_to_string(err) %></p>
          <% end %>

          </section>
        <:actions>
          <.button phx-disable-with="Saving...">Save Book</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{book: book} = assigns, socket) do
    changeset = Books.change_book(book)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image , accept: ~w(.jpg .png .jpeg), max_entries: 1)
    }
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"book" => book_params}, socket) do
    changeset =
      socket.assigns.book
      |> Books.change_book(book_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"book" => book_params}, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:bookstore), "static", "uploads", Path.basename(path)])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    new_book_params = Map.put(book_params, "image", List.first(uploaded_files))

    save_book(socket, socket.assigns.action, new_book_params)
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  def handle_event("save", %{"book" => book_params}, socket) do
    save_book(socket, socket.assigns.action, book_params)
  end

  defp save_book(socket, :edit, book_params) do
    case Books.update_book(socket.assigns.book, book_params) do
      {:ok, book} ->
        notify_parent({:saved, book})

        {:noreply,
         socket
         |> put_flash(:info, "Book updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_book(socket, :new, book_params) do
    case Books.create_book(book_params) do
      {:ok, book} ->
        notify_parent({:saved, book})

        {:noreply,
         socket
         |> put_flash(:info, "Book created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  def error_to_string(:too_large), do: "El archivo es demasiado grande"
  def error_to_string(:not_accepted), do: "Has seleccionado un tipo de archivo no aceptable"
  def error_to_string(:too_many_files), do: "Has seleccionado demasiados archivos"
end
