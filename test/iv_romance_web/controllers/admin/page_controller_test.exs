defmodule IvRomanceWeb.Admin.PageControllerTest do
  use IvRomanceWeb.ConnCase

  alias IvRomance.Admin.Content

  @create_attrs %{body: "some body", path: "/some-path", title: "some title"}
  @update_attrs %{
    body: "some updated body",
    path: "/some-updated-path",
    title: "some updated title"
  }
  @invalid_attrs %{body: nil, path: nil, title: nil}

  def fixture(:page) do
    {:ok, page} = Content.create_page(@create_attrs)
    page
  end

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get(conn, admin_page_path(conn, :index))
      assert html_response(conn, 200) =~ "Pages"
    end
  end

  describe "new page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, admin_page_path(conn, :new))
      assert html_response(conn, 200) =~ "New page"
    end
  end

  describe "create page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, admin_page_path(conn, :create), page: @create_attrs)

      assert redirected_to(conn) == admin_page_path(conn, :index)

      conn = get(conn, @create_attrs.path)
      assert html_response(conn, 200) =~ "some body"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, admin_page_path(conn, :create), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New page"
    end
  end

  describe "edit page" do
    setup [:create_page]

    test "renders form for editing chosen page", %{conn: conn, page: page} do
      conn = get(conn, admin_page_path(conn, :edit, page))
      assert html_response(conn, 200) =~ "Edit page"
    end
  end

  describe "update page" do
    setup [:create_page]

    test "redirects when data is valid", %{conn: conn, page: page} do
      conn = put(conn, admin_page_path(conn, :update, page), page: @update_attrs)
      assert redirected_to(conn) == admin_page_path(conn, :index)

      conn = get(conn, @update_attrs.path)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put(conn, admin_page_path(conn, :update, page), page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit page"
    end
  end

  describe "delete page" do
    setup [:create_page]

    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete(conn, admin_page_path(conn, :delete, page))
      assert redirected_to(conn) == admin_page_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, page.path)
      end)
    end
  end

  defp create_page(_) do
    page = fixture(:page)
    {:ok, page: page}
  end
end
