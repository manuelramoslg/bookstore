defmodule Bookstore.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :parent_id, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:categories, [:name], where: "parent_id IS NULL")
    create unique_index(:categories,[:name, :parent_id], name: :name_parent_index)
  end
end
