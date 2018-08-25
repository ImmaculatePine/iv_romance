defmodule IvRomanceWeb.PageControllerTest do
  use IvRomanceWeb.ConnCase

  test "GET /unkown-route", %{conn: conn} do
    assert_error_sent(404, fn ->
      get(conn, "/unkown-route")
    end)
  end
end
