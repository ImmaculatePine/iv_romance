defmodule IvRomanceWeb.PageController do
  use IvRomanceWeb, :controller

  alias IvRomance.Content

  def show(conn, %{"path" => path}) do
    page = find_page!(path)

    conn
    |> assign(:title, page.title)
    |> render("show.html", page: page)
  end

  defp find_page!(path) do
    path
    |> Enum.join("/")
    |> prepend_slash()
    |> Content.get_page!()
  end

  defp prepend_slash(path), do: "/" <> path
end
