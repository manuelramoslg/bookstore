defmodule BookstoreWeb.CategoryHTML do
  use BookstoreWeb, :html

  embed_templates "category_html/*"

  @doc """
  Renders a category form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :options, :list

  def category_form(assigns)
end
