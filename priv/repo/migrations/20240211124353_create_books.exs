defmodule Bookstore.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :isbn, :string
      add :publication_date, :string
      add :price, :float
      add :quantity, :integer
      add :editorial, :string

      timestamps(type: :utc_datetime)
    end
  end
end
