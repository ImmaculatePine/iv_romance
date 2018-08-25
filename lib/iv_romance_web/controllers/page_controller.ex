defmodule IvRomanceWeb.PageController do
  use IvRomanceWeb, :controller

  alias IvRomance.Content

  def show(conn, %{"path" => path}) do
    page = ["" | path] |> Enum.join("/") |> Content.get_page!()

    conn
    |> assign(:title, page.title)
    |> render("show.html", page: page)
  end
end
