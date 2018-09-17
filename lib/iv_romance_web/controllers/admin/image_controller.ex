defmodule IvRomanceWeb.Admin.ImageController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Photo
  alias IvRomance.Admin.Auth.Token
  alias IvRomance.Photo.Image

  action_fallback(IvRomanceWeb.FallbackController)

  def index(%{assigns: %{accept: ["application/json"]}} = conn, %{"gallery_id" => gallery_id}) do
    Photo.get_gallery!(gallery_id)
    images = Photo.list_images(gallery_id)
    render(conn, "index.json", images: images)
  end

  def index(%{assigns: %{current_user: %{id: user_id}}} = conn, %{"gallery_id" => gallery_id}) do
    gallery = Photo.get_gallery!(gallery_id)

    render(conn, "index.html", gallery: gallery, token: Token.sign(user_id))
  end

  def create(%{assigns: %{accept: ["application/json"]}} = conn, %{
        "gallery_id" => gallery_id,
        "image" => %{"file" => file, "position" => position}
      }) do
    with {:ok, %Image{} = image} <-
           Photo.upload_image(%{gallery_id: gallery_id, file: file, position: position}) do
      conn
      |> put_status(:created)
      |> render("image.json", image: image)
    end
  end

  def delete(%{assigns: %{accept: ["application/json"]}} = conn, %{
        "id" => id
      }) do
    image = Photo.get_image!(id)

    with {:ok, %Image{}} <- Photo.delete_image(image) do
      send_resp(conn, :no_content, "")
    end
  end
end
