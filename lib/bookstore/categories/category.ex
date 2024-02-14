defmodule Bookstore.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :parent_id, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> unique_constraint(:name, name: :name_parent_index)
  end
end
