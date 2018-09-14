defmodule IvRomanceWeb.Admin.GalleryController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Photo
  alias IvRomance.Photo.Gallery

  def index(conn, _params) do
    galleries = Photo.list_galleries()
    render(conn, "index.html", galleries: galleries)
  end

  def new(conn, _params) do
    changeset = Photo.change_gallery(%Gallery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gallery" => gallery_params}) do
    case Photo.create_gallery(gallery_params) do
      {:ok, _gallery} ->
        conn
        |> put_flash(:info, "Gallery created successfully.")
        |> redirect(to: admin_gallery_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    gallery = Photo.get_gallery!(id)
    changeset = Photo.change_gallery(gallery)
    render(conn, "edit.html", gallery: gallery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gallery" => gallery_params}) do
    gallery = Photo.get_gallery!(id)

    case Photo.update_gallery(gallery, gallery_params) do
      {:ok, _gallery} ->
        conn
        |> put_flash(:info, "Gallery updated successfully.")
        |> redirect(to: admin_gallery_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gallery: gallery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gallery = Photo.get_gallery!(id)
    {:ok, _gallery} = Photo.delete_gallery(gallery)

    conn
    |> put_flash(:info, "Gallery deleted successfully.")
    |> redirect(to: admin_gallery_path(conn, :index))
  end
end
