defmodule IvRomanceWeb.PageController do
  use IvRomanceWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
