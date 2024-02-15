defmodule BookstoreWeb.BookLive.Index do
  use BookstoreWeb, :live_view

  alias Bookstore.Books
  alias Bookstore.Books.Book
  alias Bookstore.Authors

  @impl true
  def mount(_params, _session, socket) do
    authors = Authors.list_authors()
    {:ok,
    socket
    |> assign(page: 1, per_page: 3)
    |> assign(authors: authors)
    |> paginate_books(1)
  }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Book")
    |> assign(:book, Books.get_book!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Book")
    |> assign(:book, %Book{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Books")
    |> assign(:book, nil)
  end

  @impl true
  def handle_info({BookstoreWeb.BookLive.FormComponent, {:saved, book}}, socket) do
    {:noreply, stream_insert(socket, :books, book)}
  end

  defp paginate_books(socket, new_page) when new_page >= 1 do
    %{per_page: per_page, page: cur_page} = socket.assigns
    books = Books.list_books(per_page, (new_page - 1) * per_page)

    {books, at} =
      if new_page >= cur_page do
        {books, -1}
      end

    socket
    |> assign(:page, new_page)
    |> stream(:books, books, at: at)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    book = Books.get_book!(id)
    {:ok, _} = Books.delete_book(book)

    {:noreply, stream_delete(socket, :books, book)}
  end

  @impl true
  def handle_event("next-page", _, socket) do
    {:noreply, paginate_books(socket, socket.assigns.page + 1)}
  end
end
