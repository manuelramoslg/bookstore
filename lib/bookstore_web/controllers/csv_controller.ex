defmodule BookstoreWeb.CsvController do
  use BookstoreWeb, :controller

  alias Bookstore.Books

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"books.csv\"")
    |> send_resp(200, csv_content())
  end

  defp csv_content do
    books = Books.list_books()
    books
    |> Stream.map(&[&1.id, &1.title, &1.isbn, &1.publication_date, &1.price, &1.quantity, &1.editorial, get_author_names(&1.authors)])
    |> CSV.encode()
    |> Enum.to_list
    |> to_string
  end

  defp get_author_names(authors) do
    Enum.map_join(authors, ", ", &(&1.full_name))
  end
end
