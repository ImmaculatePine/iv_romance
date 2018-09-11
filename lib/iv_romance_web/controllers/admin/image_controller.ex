defmodule IvRomanceWeb.Admin.ImageController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Galleries

  def index(conn, %{"gallery_id" => gallery_id}) do
    gallery = Galleries.get_gallery!(gallery_id)
    images = Galleries.list_images(gallery_id)

    render(conn, "index.html", gallery: gallery, images: images)
  end

  def create(conn, %{"gallery_id" => gallery_id, "image" => %{"file" => %Plug.Upload{} = file}}) do
    case Galleries.upload_image(gallery_id, file) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "Image uploaded successfully.")
        |> redirect(to: admin_gallery_image_path(conn, :index, gallery_id))

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed to upload image.")
        |> redirect(to: admin_gallery_image_path(conn, :index, gallery_id))
    end
  end

  def delete(conn, %{"gallery_id" => gallery_id, "id" => id}) do
    image = Galleries.get_image!(id)
    {:ok, _image} = Galleries.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: admin_gallery_image_path(conn, :index, gallery_id))
  end
end
