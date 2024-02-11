defmodule Bookstore.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :publication_date, :string
    field :price, :float
    field :quantity, :integer
    field :editorial, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :publication_date, :price, :quantity, :editorial])
    |> validate_required([:title, :isbn, :publication_date, :price, :quantity, :editorial])
  end
end
