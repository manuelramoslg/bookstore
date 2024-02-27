defmodule Bookstore.AuthorBooks.AuthorBook do
  use Ecto.Schema
  import Ecto.Changeset

  Bookstore.Authors.Author
  Bookstore.Books.Book

  @primary_key false
  schema "author_books" do
    belongs_to :book, Book
    belongs_to :author, Author

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author_book, attrs) do
    author_book
    |> cast(attrs, [:author_id, :book_id])
    |> validate_required([:author_id, :book_id])
    |> unique_constraint([:author_id, :book_id],
      name: :author_books_index,
      message: "The author_books_index already exist"
    )
  end
end
