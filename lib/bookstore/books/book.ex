defmodule Bookstore.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bookstore.Authors.Author
  alias Bookstore.AuthorBooks.AuthorBook

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :publication_date, :string
    field :price, :float, default: 1.0
    field :quantity, :integer, default: 1
    field :editorial, :string
    field :image, :string

    many_to_many :authors, Author, join_through: AuthorBook,  on_replace: :delete
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :publication_date, :price, :quantity, :editorial, :image])
    |> validate_required([:title, :isbn, :publication_date, :price, :quantity, :editorial])
  end
end
