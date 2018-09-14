defmodule IvRomanceWeb.GalleryControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  alias IvRomanceWeb.GalleryView
  alias Ecto.UUID

  describe "index" do
    test "lists all galleries", %{conn: conn} do
      galleries = insert_list(3, :gallery)

      response =
        conn
        |> get(gallery_path(conn, :index))
        |> html_response(200)

      Enum.each(galleries, fn %{id: id, title: title} ->
        assert response =~ id
        assert response =~ title
      end)
    end
  end

  describe "show" do
    test "lists gallery images", %{conn: conn} do
      %{title: title} = gallery = insert(:gallery)
      images = insert_list(3, :image, gallery: gallery)

      response =
        conn
        |> get(gallery_path(conn, :show, gallery))
        |> html_response(200)

      assert response =~ title

      Enum.each(images, fn %{id: id} = image ->
        assert response =~ id
        assert response =~ GalleryView.thumb_url(image)
        assert response =~ GalleryView.original_url(image)
      end)
    end

    test "responds with 404 for non-existent gallery", %{conn: conn} do
      assert_error_sent(404, fn ->
        get(conn, gallery_path(conn, :show, UUID.generate()))
      end)
    end
  end
end
