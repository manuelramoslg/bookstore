defmodule Bookstore.BooksTest do
  use Bookstore.DataCase

  alias Bookstore.Books

  describe "books" do
    alias Bookstore.Books.Book

    import Bookstore.BooksFixtures

    @invalid_attrs %{title: nil, isbn: nil, publication_date: nil, price: nil, quantity: nil, editorial: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{title: "some title", isbn: "some isbn", publication_date: "some publication_date", price: 120.5, quantity: 42, editorial: "some editorial"}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.title == "some title"
      assert book.isbn == "some isbn"
      assert book.publication_date == "some publication_date"
      assert book.price == 120.5
      assert book.quantity == 42
      assert book.editorial == "some editorial"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{title: "some updated title", isbn: "some updated isbn", publication_date: "some updated publication_date", price: 456.7, quantity: 43, editorial: "some updated editorial"}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.title == "some updated title"
      assert book.isbn == "some updated isbn"
      assert book.publication_date == "some updated publication_date"
      assert book.price == 456.7
      assert book.quantity == 43
      assert book.editorial == "some updated editorial"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
