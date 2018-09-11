defmodule IvRomanceWeb.Admin.GalleryControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, conn: assign(conn, :current_user, user)}
  end

  describe "index" do
    test "lists all galleries", %{conn: conn} do
      galleries = insert_list(3, :gallery)

      response =
        conn
        |> get(admin_gallery_path(conn, :index))
        |> html_response(200)

      Enum.each(galleries, fn %{title: title} ->
        assert response =~ title
      end)
    end
  end

  describe "new gallery" do
    test "renders form", %{conn: conn} do
      response =
        conn
        |> get(admin_gallery_path(conn, :new))
        |> html_response(200)

      assert response =~ "New gallery"
    end
  end

  describe "create gallery" do
    test "redirects to index when data is valid", %{conn: conn} do
      %{title: title} = params = params_for(:gallery)

      assert admin_gallery_path(conn, :index) ==
               conn
               |> post(admin_gallery_path(conn, :create), gallery: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_path(conn, :index))
               |> html_response(200)

      assert response =~ title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      assert response =
               conn
               |> post(admin_gallery_path(conn, :create), gallery: %{})
               |> html_response(200)

      assert response =~ "New gallery"
    end
  end

  describe "edit gallery" do
    test "renders form for editing chosen gallery", %{conn: conn} do
      gallery = insert(:gallery)

      assert response =
               conn
               |> get(admin_gallery_path(conn, :edit, gallery))
               |> html_response(200)

      assert response =~ "Edit gallery"
    end
  end

  describe "update gallery" do
    test "redirects to the updated gallery when data is valid", %{conn: conn} do
      %{title: old_title} = gallery = insert(:gallery)
      %{title: title} = params = params_for(:gallery)

      assert admin_gallery_path(conn, :index) ==
               conn
               |> put(admin_gallery_path(conn, :update, gallery), gallery: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_path(conn, :index))
               |> html_response(200)

      refute response =~ old_title
      assert response =~ title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      gallery = insert(:gallery)

      response =
        conn
        |> put(admin_gallery_path(conn, :update, gallery), gallery: %{title: ""})
        |> html_response(200)

      assert response =~ "Edit gallery"
    end
  end

  describe "delete gallery" do
    test "deletes chosen gallery", %{conn: conn} do
      %{title: title} = gallery = insert(:gallery)

      assert admin_gallery_path(conn, :index) ==
               conn
               |> delete(admin_gallery_path(conn, :delete, gallery))
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_path(conn, :index))
               |> html_response(200)

      refute response =~ title
    end
  end
end
