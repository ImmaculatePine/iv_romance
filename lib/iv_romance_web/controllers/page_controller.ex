defmodule IvRomanceWeb.PageController do
  use IvRomanceWeb, :controller

  alias IvRomance.Content
  alias IvRomance.Content.Page

  def show(conn, %{"path" => path}) do
    page = find_page!(path)

    conn
    |> assign(:title, page.title)
    |> render("show.html", page: page)
  end

  defp find_page!(path) do
    page =
      ["" | path]
      |> Enum.join("/")
      |> Content.get_page!()
  end
end
