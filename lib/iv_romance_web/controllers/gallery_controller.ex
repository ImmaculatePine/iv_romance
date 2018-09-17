defmodule IvRomanceWeb.GalleryController do
  use IvRomanceWeb, :controller

  alias IvRomance.Photo

  def index(conn, _params) do
    galleries = Photo.list_galleries()
    render(conn, "index.html", galleries: galleries)
  end

  def show(conn, %{"id" => id}) do
    gallery = Photo.get_gallery!(id)
    images = Photo.list_images(id)
    render(conn, "show.html", gallery: gallery, images: images)
  end
end
