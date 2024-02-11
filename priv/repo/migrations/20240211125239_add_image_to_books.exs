defmodule Bookstore.Repo.Migrations.AddImageToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add(:image, :string)
    end
  end
end
