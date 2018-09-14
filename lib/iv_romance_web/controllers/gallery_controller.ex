defmodule IvRomanceWeb.GalleryController do
  use IvRomanceWeb, :controller

  alias IvRomance.Photo

  def index(conn, _params) do
    galleries = Photo.list_galleries()
    render(conn, "index.html", galleries: galleries)
  end

  def show(conn, %{"id" => id}) do
    %{images: images} = gallery = Photo.get_gallery!(id)
    render(conn, "show.html", gallery: gallery, images: images)
  end
end
