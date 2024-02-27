defmodule Bookstore.AuthorsTest do
  use Bookstore.DataCase

  alias Bookstore.Authors

  describe "authors" do
    alias Bookstore.Authors.Author

    import Bookstore.AuthorsFixtures

    @invalid_attrs %{full_name: nil, birthday: nil, nationality: nil}

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Authors.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Authors.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{full_name: "some full_name", birthday: ~D[2024-02-14], nationality: "some nationality"}

      assert {:ok, %Author{} = author} = Authors.create_author(valid_attrs)
      assert author.full_name == "some full_name"
      assert author.birthday == ~D[2024-02-14]
      assert author.nationality == "some nationality"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authors.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{full_name: "some updated full_name", birthday: ~D[2024-02-15], nationality: "some updated nationality"}

      assert {:ok, %Author{} = author} = Authors.update_author(author, update_attrs)
      assert author.full_name == "some updated full_name"
      assert author.birthday == ~D[2024-02-15]
      assert author.nationality == "some updated nationality"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Authors.update_author(author, @invalid_attrs)
      assert author == Authors.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Authors.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Authors.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Authors.change_author(author)
    end
  end
end
