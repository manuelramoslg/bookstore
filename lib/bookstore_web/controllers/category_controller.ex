defmodule BookstoreWeb.CategoryController do
  use BookstoreWeb, :controller

  alias Bookstore.Categories
  alias Bookstore.Categories.Category

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end

  def new(conn, _params) do
    changeset = Categories.change_category(%Category{})
    options = Categories.list_categories()
    render(conn, :new, changeset: changeset, options: options)
  end

  def create(conn, %{"category" => category_params}) do
    options = Categories.list_categories()
    case Categories.create_category(category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: ~p"/categories/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, options: options)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, :show, category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    changeset = Categories.change_category(category)
    # Remove parent's where category name present
    options =
      for {k, v} <- Enum.frequencies(Categories.list_categories()),
      v == category.name, do: k

    render(conn, :edit, category: category, changeset: changeset, options: options)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    case Categories.update_category(category, category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: ~p"/categories/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    {:ok, _category} = Categories.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: ~p"/categories")
  end
end
