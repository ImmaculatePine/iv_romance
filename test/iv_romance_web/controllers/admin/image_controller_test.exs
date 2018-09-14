defmodule IvRomanceWeb.Admin.ImageControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  alias Ecto.UUID
  alias IvRomance.Admin.Photo

  setup %{conn: conn} do
    on_exit(fn ->
      File.rm_rf!("uploads")
    end)

    user = insert(:user)
    gallery = insert(:gallery)
    {:ok, conn: assign(conn, :current_user, user), gallery: gallery}
  end

  describe "index" do
    test "responses with 404 error if gallery does not exist", %{conn: conn} do
      assert_error_sent(404, fn ->
        get(conn, admin_gallery_image_path(conn, :index, UUID.generate()))
      end)
    end

    test "lists all images in the selected gallery", %{conn: conn, gallery: gallery} do
      images = insert_list(3, :image, gallery: gallery)

      response =
        conn
        |> get(admin_gallery_image_path(conn, :index, gallery))
        |> html_response(200)

      Enum.each(images, fn %{id: id} ->
        assert response =~ id
      end)
    end
  end

  describe "create image" do
    test "redirects to index when data is valid", %{conn: conn, gallery: gallery} do
      params = %{
        file: %Plug.Upload{filename: "image.png", path: "test/fixtures/image.png"}
      }

      assert admin_gallery_image_path(conn, :index, gallery) ==
               conn
               |> post(admin_gallery_image_path(conn, :create, gallery), image: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_image_path(conn, :index, gallery))
               |> html_response(200)

      assert response =~ "thumb.png"
    end

    test "redirects to index when data is invalid", %{conn: conn, gallery: gallery} do
      params = %{
        file: %Plug.Upload{filename: "text.txt", path: "test/fixtures/text.txt"}
      }

      assert admin_gallery_image_path(conn, :index, gallery) ==
               conn
               |> post(admin_gallery_image_path(conn, :create, gallery), image: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_image_path(conn, :index, gallery))
               |> html_response(200)

      refute response =~ "thumb.png"
    end
  end

  describe "delete image" do
    test "deletes chosen image", %{conn: conn, gallery: gallery} do
      params = %{
        file: %Plug.Upload{filename: "image.png", path: "test/fixtures/image.png"}
      }

      assert admin_gallery_image_path(conn, :index, gallery) ==
               conn
               |> post(admin_gallery_image_path(conn, :create, gallery), image: params)
               |> redirected_to()

      [%{id: id}] = [image] = Photo.list_images(gallery.id)

      assert admin_gallery_image_path(conn, :index, gallery) ==
               conn
               |> delete(admin_gallery_image_path(conn, :delete, gallery, image))
               |> redirected_to()

      assert response =
               conn
               |> get(admin_gallery_image_path(conn, :index, gallery))
               |> html_response(200)

      refute response =~ id
    end
  end
end
