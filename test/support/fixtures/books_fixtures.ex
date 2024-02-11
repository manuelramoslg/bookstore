defmodule Bookstore.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bookstore.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        editorial: "some editorial",
        isbn: "some isbn",
        price: 120.5,
        publication_date: "some publication_date",
        quantity: 42,
        title: "some title"
      })
      |> Bookstore.Books.create_book()

    book
  end
end
