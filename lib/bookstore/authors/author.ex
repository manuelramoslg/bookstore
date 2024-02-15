defmodule Bookstore.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bookstore.Books.Book
  alias Bookstore.AuthorBooks

  schema "authors" do
    field :full_name, :string
    field :birthday, :date
    field :nationality, :string

    many_to_many :books, Book, join_through: AuthorBooks
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:full_name, :birthday, :nationality])
    |> validate_required([:full_name, :birthday])
    |> unique_constraint([:full_name, :birthday], name: :full_name_birthday)
    |> validate_date_before_today(:birthday)
  end

  defp validate_date_before_today(changeset, field) do
    today = Date.utc_today()
    case get_change(changeset, field) do
      nil -> changeset
      date ->
        if date >= today do
          add_error(changeset, field, "must be before today")
        else
          changeset
        end
    end
  end
end
