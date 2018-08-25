defmodule IvRomanceWeb.PageControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  test "GET /unknown-route", %{conn: conn} do
    assert_error_sent(404, fn ->
      get(conn, "/unknown-route")
    end)
  end

  test "GET /known-route", %{conn: conn} do
    %{path: path, title: title, body: body} = insert(:page)

    assert response =
             conn
             |> get(path)
             |> html_response(:ok)

    assert response =~ title
    assert response =~ body
  end
end
