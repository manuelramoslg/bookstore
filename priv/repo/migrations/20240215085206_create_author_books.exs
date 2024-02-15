defmodule Bookstore.Repo.Migrations.CreateAuthorBooks do
  use Ecto.Migration

  def change do
    create table(:author_books, primary_key: false) do
      add :author_id, references(:authors, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:author_books, [:book_id, :author_id])
  end
end
