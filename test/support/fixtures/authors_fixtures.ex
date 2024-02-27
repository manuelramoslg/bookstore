defmodule Bookstore.AuthorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bookstore.Authors` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        birthday: ~D[2024-02-14],
        full_name: "some full_name",
        nationality: "some nationality"
      })
      |> Bookstore.Authors.create_author()

    author
  end
end
