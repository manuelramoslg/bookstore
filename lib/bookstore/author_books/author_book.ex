defmodule Bookstore.AuthorBooks.AuthorBook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "author_books" do
    field :author_id, :id
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author_book, attrs) do
    author_book
    |> cast(attrs, [:author_id, :book_id])
    |> validate_required([:author_id, :book_id])
    |> foreign_key_constraint(:author_id)
    |> foreign_key_constraint(:book_id)
    |> unique_constraint([:author_id, :book_id],
      name: :author_books_index,
      message: "The author_books_index already exist"
    )
  end
end
