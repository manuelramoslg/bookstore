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

book_data = [
  %{
    :editorial => "George Allen & Unwin",
    :isbn => "978-0261102385",
    :price => "9.99",
    :publication_date => "21 September 1937",
    :quantity => "100",
    :title => "The Hobbit",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "HarperCollins",
    :isbn => "978-0061238961",
    :price => "8.99",
    :publication_date => "29 July 1954",
    :quantity => "150",
    :title => "The Lord of the Rings: The Fellowship of the Ring",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "HarperCollins",
    :isbn => "978-0261102361",
    :price => "9.99",
    :publication_date => "11 November 1954",
    :quantity => "120",
    :title => "The Lord of the Rings: The Two Towers",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "HarperCollins",
    :isbn => "978-0261103573",
    :price => "9.99",
    :publication_date => "20 October 1955",
    :quantity => "110",
    :title => "The Lord of the Rings: The Return of the King",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Bloomsbury Publishing",
    :isbn => "978-0747538493",
    :price => "10.99",
    :publication_date => "26 June 1997",
    :quantity => "200",
    :title => "Harry Potter and the Philosopher's Stone",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Bloomsbury Publishing",
    :isbn => "978-0747532743",
    :price => "11.99",
    :publication_date => "2 July 1998",
    :quantity => "180",
    :title => "Harry Potter and the Chamber of Secrets",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Arthur A. Levine Books",
    :isbn => "978-0439358071",
    :price => "12.99",
    :publication_date => "8 July 2000",
    :quantity => "250",
    :title => "Harry Potter and the Goblet of Fire",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Arthur A. Levine Books",
    :isbn => "978-0439064866",
    :price => "13.99",
    :publication_date => "21 June 2003",
    :quantity => "220",
    :title => "Harry Potter and the Order of the Phoenix",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Arthur A. Levine Books",
    :isbn => "978-0439785969",
    :price => "14.99",
    :publication_date => "16 July 2005",
    :quantity => "210",
    :title => "Harry Potter and the Half-Blood Prince",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Arthur A. Levine Books",
    :isbn => "978-0545139700",
    :price => "15.99",
    :publication_date => "21 July 2007",
    :quantity => "200",
    :title => "Harry Potter and the Deathly Hallows",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Scholastic",
    :isbn => "978-0439023481",
    :price => "16.99",
    :publication_date => "15 September 1998",
    :quantity => "220",
    :title => "Harry Potter and the Sorcerer's Stone",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Scholastic",
    :isbn => "978-0439136365",
    :price => "17.99",
    :publication_date => "2 June 1999",
    :quantity => "230",
    :title => "Harry Potter and the Prisoner of Azkaban",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Scholastic",
    :isbn => "978-0545582889",
    :price => "18.99",
    :publication_date => "16 July 2005",
    :quantity => "210",
    :title => "Harry Potter and the Half-Blood Prince",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Penguin Books",
    :isbn => "978-0140286805",
    :price => "19.99",
    :publication_date => "1 January 1997",
    :quantity => "240",
    :title => "The Alchemist",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Ace Books",
    :isbn => "978-0441007318",
    :price => "20.99",
    :publication_date => "1 September 1988",
    :quantity => "250",
    :title => "Assassin's Apprentice",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "HarperCollins",
    :isbn => "978-0064407666",
    :price => "21.99",
    :publication_date => "5 July 1996",
    :quantity => "260",
    :title => "A Game of Thrones",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Bantam Books",
    :isbn => "978-0553573404",
    :price => "22.99",
    :publication_date => "17 July 1996",
    :quantity => "270",
    :title => "A Clash of Kings",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Voyager Books",
    :isbn => "978-0007119554",
    :price => "23.99",
    :publication_date => "4 August 1997",
    :quantity => "280",
    :title => "A Storm of Swords",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "HarperCollins",
    :isbn => "978-0061055884",
    :price => "24.99",
    :publication_date => "15 November 1998",
    :quantity => "290",
    :title => "A Feast for Crows",
    :image => "/uploads/default-book.jpg"
  },
  %{
    :editorial => "Bantam Books",
    :isbn => "978-0553588484",
    :price => "25.99",
    :publication_date => "16 November 2000",
    :quantity => "300",
    :title => "A Dance with Dragons",
    :image => "/uploads/default-book.jpg"
  }
]

Enum.each(book_data, fn(data) ->
  Books.create_book(data)
end)

alias Bookstore.Categories
Categories.create_category(%{name: "Sin Categoria"})

alias Bookstore.Authors
Authors.create_author(
  %{
    full_name: "Manuel Ramos La Gambino",
    birthday: ~D[2024-02-13],
    nationality: "Venezolano",
  }
)
