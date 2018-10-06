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

  describe "index html" do
    test "responses with 404 error if gallery does not exist", %{conn: conn} do
      assert_error_sent(404, fn ->
        get(conn, admin_gallery_image_path(conn, :index, UUID.generate()))
      end)
    end

    test "lists all images in the selected gallery", %{conn: conn, gallery: gallery} do
      %{title: title} = gallery

      response =
        conn
        |> get(admin_gallery_image_path(conn, :index, gallery))
        |> html_response(200)

      assert response =~ title
    end
  end

  describe "index json" do
    test "responses with 404 error if gallery does not exist", %{conn: conn} do
      assert_error_sent(404, fn ->
        conn
        |> put_req_header("accept", "application/json")
        |> get(api_admin_gallery_image_path(conn, :index, UUID.generate()))
      end)
    end

    test "lists all images in the selected gallery", %{conn: conn, gallery: gallery} do
      [image_1, image_2, image_3] = insert_list(3, :image, gallery: gallery)

      response =
        conn
        |> put_req_header("accept", "application/json")
        |> get(api_admin_gallery_image_path(conn, :index, gallery))
        |> json_response(200)

      assert response == [
               %{
                 "id" => image_1.id,
                 "position" => image_1.position,
                 "thumb_url" => "/uploads/images/#{image_1.id}/thumb.png"
               },
               %{
                 "id" => image_2.id,
                 "position" => image_2.position,
                 "thumb_url" => "/uploads/images/#{image_2.id}/thumb.png"
               },
               %{
                 "id" => image_3.id,
                 "position" => image_3.position,
                 "thumb_url" => "/uploads/images/#{image_3.id}/thumb.png"
               }
             ]
    end
  end

  describe "create image json" do
    test "returns created image when data is valid", %{conn: conn, gallery: gallery} do
      params = %{
        position: 1,
        file: %Plug.Upload{filename: "image.png", path: "test/fixtures/image.png"}
      }

      assert response =
               conn
               |> put_req_header("accept", "application/json")
               |> post(api_admin_gallery_image_path(conn, :create, gallery), image: params)
               |> json_response(201)

      assert %{
               "id" => id,
               "position" => 1,
               "thumb_url" => thumb_url
             } = response

      assert thumb_url == "/uploads/images/#{id}/thumb.png"
    end

    test "returns error when data is invalid", %{conn: conn, gallery: gallery} do
      params = %{
        position: 1,
        file: %Plug.Upload{filename: "text.txt", path: "test/fixtures/text.txt"}
      }

      assert response =
               conn
               |> put_req_header("accept", "application/json")
               |> post(api_admin_gallery_image_path(conn, :create, gallery), image: params)
               |> json_response(500)

      assert response == %{"error" => "invalid_file"}
    end
  end

  describe "delete image json" do
    test "deletes chosen image", %{conn: conn, gallery: gallery} do
      params = %{
        position: 1,
        file: %Plug.Upload{filename: "image.png", path: "test/fixtures/image.png"}
      }

      assert conn
             |> put_req_header("accept", "application/json")
             |> post(api_admin_gallery_image_path(conn, :create, gallery), image: params)
             |> json_response(201)

      [image] = Photo.list_images(gallery.id)

      assert "" ==
               conn
               |> put_req_header("accept", "application/json")
               |> delete(api_admin_gallery_image_path(conn, :delete, gallery, image))
               |> response(204)
    end
  end
end
