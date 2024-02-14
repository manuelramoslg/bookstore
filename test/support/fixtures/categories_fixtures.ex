defmodule Bookstore.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bookstore.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name",
        parent_id: 42
      })
      |> Bookstore.Categories.create_category()

    category
  end
end
