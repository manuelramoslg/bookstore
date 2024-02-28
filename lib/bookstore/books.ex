defmodule Bookstore.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Bookstore.Repo

  alias Bookstore.Books.Book
  alias Bookstore.Authors.Author

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    query = from p in Book, preload: [:authors]
    Repo.all(query)
  end

  def list_books(limit, offset) do
    query = from(p in Book, limit: ^limit, offset: ^offset)
    Repo.all(query)
  end


  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id) do
    Book |> Repo.get!(id) |> Repo.preload(:authors)
  end

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> change_book(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      {:ok, %Book{}}

      iex> update_book(book, %{field: new_value})
      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> change_book(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    authors = list_authors_by_id(attrs["author_ids"])

    book
    |> Repo.preload([:authors])
    |> Book.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:authors, authors)
  end

  def list_authors_by_id(nil), do: []
  def list_authors_by_id(author_ids) do
    Repo.all(from a in Author, where: a.id in ^author_ids)
  end

  def get_author_id_where_name(search_term) do
    search_term = "%#{search_term}%"

    query =
      from(
        a in Author,
        where: ilike(a.full_name, ^search_term)
      )

    Enum.map(Repo.all(query), &(&1.id))
  end
end
