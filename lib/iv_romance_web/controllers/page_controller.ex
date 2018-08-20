defmodule IvRomanceWeb.PageController do
  use IvRomanceWeb, :controller

  def show(conn, %{"path" => path}) do
    render(conn, "show.html", path: Enum.join(path, "/"))
  end
end
