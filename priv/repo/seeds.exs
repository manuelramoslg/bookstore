# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bookstore.Repo.insert!(%Bookstore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bookstore.Books
alias Bookstore.Authors
authors_data = [
  %{full_name: "J.R.R. Tolkien", birthday: ~D[1892-01-03], nationality: "British"},
  %{full_name: "J.K. Rowling", birthday: ~D[1965-07-31], nationality: "British"},
  %{full_name: "Paulo Coelho", birthday: ~D[1947-08-24], nationality: "Brazilian"},
  %{full_name: "Robin Hobb", birthday: ~D[1952-03-05], nationality: "American"},
  %{full_name: "George R.R. Martin", birthday: ~D[1948-09-20], nationality: "American"}
]
Enum.each(authors_data, fn(author) ->
  Authors.create_author(author)
end)

book_data = [
  %{"author_ids" => [1], "title" => "The Hobbit", "isbn" => "978-0261102385", "publication_date" => "21 September 1937", "price" => 9.99, "quantity" => 100, "editorial" => "George Allen & Unwin", "image" => "/uploads/live_view_upload-1709031713-404143854860-1"},
  %{"author_ids" => [1], "title" => "The Lord of the Rings: The Fellowship of the Ring", "isbn" => "978-0061238961", "publication_date" => "29 July 1954", "price" => 8.99, "quantity" => 150, "editorial" => "HarperCollins", "image" => "/uploads/live_view_upload-1709031736-86340392889-2"},
  %{"author_ids" => [1], "title" => "The Lord of the Rings: The Two Towers", "isbn" => "978-0261102361", "publication_date" => "11 November 1954", "price" => 9.99, "quantity" => 120, "editorial" => "HarperCollins", "image" => "/uploads/live_view_upload-1709031752-977842318747-1"},
  %{"author_ids" => [1], "title" => "The Lord of the Rings: The Return of the King", "isbn" => "978-0261103573", "publication_date" => "20 October 1955", "price" => 9.99, "quantity" => 110, "editorial" => "HarperCollins", "image" => "/uploads/live_view_upload-1709031770-604435268735-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Philosopher's Stone", "isbn" => "978-0747538493", "publication_date" => "26 June 1997", "price" => 10.99, "quantity" => 200, "editorial" => "Bloomsbury Publishing", "image" => "/uploads/live_view_upload-1709031789-428004730287-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Chamber of Secrets", "isbn" => "978-0747532743", "publication_date" => "2 July 1998", "price" => 11.99, "quantity" => 180, "editorial" => "Bloomsbury Publishing", "image" => "/uploads/live_view_upload-1709031801-806213583465-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Goblet of Fire", "isbn" => "978-0439358071", "publication_date" => "8 July 2000", "price" => 12.99, "quantity" => 250, "editorial" => "Arthur A. Levine Books", "image" => "/uploads/live_view_upload-1709031812-807643088372-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Order of the Phoenix", "isbn" => "978-0439064866", "publication_date" => "21 June 2003", "price" => 13.99, "quantity" => 220, "editorial" => "Arthur A. Levine Books", "image" => "/uploads/live_view_upload-1709031823-608111645890-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Half-Blood Prince", "isbn" => "978-0439785969", "publication_date" => "16 July 2005", "price" => 14.99, "quantity" => 210, "editorial" => "Arthur A. Levine Books", "image" => "/uploads/live_view_upload-1709031843-479791109278-1"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Deathly Hallows", "isbn" => "978-0545139700", "publication_date" => "21 July 2007", "price" => 15.99, "quantity" => 200, "editorial" => "Arthur A. Levine Books", "image" => "/uploads/live_view_upload-1709031854-515229094403-2"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Sorcerer's Stone", "isbn" => "978-0439023481", "publication_date" => "15 September 1998", "price" => 16.99, "quantity" => 220, "editorial" => "Scholastic", "image" => "/uploads/live_view_upload-1709031864-533295257342-2"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Prisoner of Azkaban", "isbn" => "978-0439136365", "publication_date" => "2 June 1999", "price" => 17.99, "quantity" => 230, "editorial" => "Scholastic", "image" => "/uploads/live_view_upload-1709031881-956539883346-2"},
  %{"author_ids" => [2], "title" => "Harry Potter and the Half-Blood Prince", "isbn" => "978-0545582889", "publication_date" => "16 July 2005", "price" => 18.99, "quantity" => 210, "editorial" => "Scholastic", "image" => "/uploads/live_view_upload-1709031905-170476211036-2"},
  %{"author_ids" => [3], "title" => "The Alchemist", "isbn" => "978-0140286805", "publication_date" => "1 January 1997", "price" => 19.99, "quantity" => 240, "editorial" => "Penguin Books", "image" => "/uploads/live_view_upload-1709031915-922592500181-3"},
  %{"author_ids" => [4], "title" => "Assassin's Apprentice", "isbn" => "978-0441007318", "publication_date" => "1 September 1988", "price" => 20.99, "quantity" => 250, "editorial" => "Ace Books", "image" => "/uploads/live_view_upload-1709031931-508424211304-1"},
  %{"author_ids" => [5], "title" => "A Game of Thrones", "isbn" => "978-0064407666", "publication_date" => "5 July 1996", "price" => 21.99, "quantity" => 260, "editorial" => "HarperCollins", "image" => "/uploads/live_view_upload-1709031942-252559174773-3"},
  %{"author_ids" => [5], "title" => "A Clash of Kings", "isbn" => "978-0553573404", "publication_date" => "17 July 1996", "price" => 22.99, "quantity" => 270, "editorial" => "Bantam Books", "image" => "/uploads/live_view_upload-1709031957-773090073312-3"},
  %{"author_ids" => [5], "title" => "A Storm of Swords", "isbn" => "978-0007119554", "publication_date" => "4 August 1997", "price" => 23.99, "quantity" => 280, "editorial" => "Voyager Books", "image" => "/uploads/live_view_upload-1709031967-203704305586-2"},
  %{"author_ids" => [5], "title" => "A Feast for Crows", "isbn" => "978-0061055884", "publication_date" => "15 November 1998", "price" => 24.99, "quantity" => 290, "editorial" => "HarperCollins", "image" => "/uploads/live_view_upload-1709031977-950067273991-3"},
  %{"author_ids" => [5], "title" => "A Dance with Dragons", "isbn" => "978-0553588484", "publication_date" => "16 November 2000", "price" => 25.99, "quantity" => 300, "editorial" => "Bantam Books", "image" => "/uploads/live_view_upload-1709031991-865873315799-3"}
]

Enum.each(book_data, fn(data) ->
  Books.create_book(data)
end)

alias Bookstore.Categories
Categories.create_category(%{name: "Sin Categoria"})
