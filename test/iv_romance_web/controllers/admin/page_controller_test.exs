defmodule IvRomanceWeb.Admin.PageControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  describe "index" do
    test "lists all pages", %{conn: conn} do
      pages = insert_list(3, :page)

      response =
        conn
        |> get(admin_page_path(conn, :index))
        |> html_response(200)

      Enum.each(pages, fn %{path: path, title: title} ->
        assert response =~ path
        assert response =~ title
      end)
    end
  end

  describe "new page" do
    test "renders form", %{conn: conn} do
      response =
        conn
        |> get(admin_page_path(conn, :new))
        |> html_response(200)

      assert response =~ "New page"
    end
  end

  describe "create page" do
    test "redirects to show when data is valid", %{conn: conn} do
      %{path: path, title: title, body: body} = params = params_for(:page)

      assert admin_page_path(conn, :index) ==
               conn
               |> post(admin_page_path(conn, :create), page: params)
               |> redirected_to()

      assert response =
               conn
               |> get(path)
               |> html_response(200)

      assert response =~ title
      assert response =~ body
    end

    test "renders errors when data is invalid", %{conn: conn} do
      assert response =
               conn
               |> post(admin_page_path(conn, :create), page: %{})
               |> html_response(200)

      assert response =~ "New page"
    end
  end

  describe "edit page" do
    test "renders form for editing chosen page", %{conn: conn} do
      page = insert(:page)

      assert response =
               conn
               |> get(admin_page_path(conn, :edit, page))
               |> html_response(200)

      assert response =~ "Edit page"
    end
  end

  describe "update page" do
    test "redirects to the updated page when data is valid", %{conn: conn} do
      page = insert(:page)
      %{path: path, title: title, body: body} = params = params_for(:page)

      assert admin_page_path(conn, :index) ==
               conn
               |> put(admin_page_path(conn, :update, page), page: params)
               |> redirected_to()

      assert response =
               conn
               |> get(path)
               |> html_response(200)

      assert response =~ title
      assert response =~ body
    end

    test "renders errors when data is invalid", %{conn: conn} do
      page = insert(:page)

      response =
        conn
        |> put(admin_page_path(conn, :update, page), page: %{path: ""})
        |> html_response(200)

      assert response =~ "Edit page"
    end
  end

  describe "delete page" do
    test "deletes chosen page", %{conn: conn} do
      %{path: path} = page = insert(:page)

      assert admin_page_path(conn, :index) ==
               conn
               |> delete(admin_page_path(conn, :delete, page))
               |> redirected_to()

      assert_error_sent(404, fn ->
        get(conn, path)
      end)
    end
  end
end
