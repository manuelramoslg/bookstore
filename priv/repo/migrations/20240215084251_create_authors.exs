defmodule Bookstore.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :full_name, :string
      add :birthday, :date
      add :nationality, :string

      timestamps(type: :utc_datetime)
    end
    create unique_index(:authors,[:full_name, :birthday], name: :full_name_birthday)
  end
end
