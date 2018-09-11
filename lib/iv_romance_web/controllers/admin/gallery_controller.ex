defmodule IvRomanceWeb.Admin.GalleryController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Galleries
  alias IvRomance.Galleries.Gallery

  def index(conn, _params) do
    galleries = Galleries.list_galleries()
    render(conn, "index.html", galleries: galleries)
  end

  def new(conn, _params) do
    changeset = Galleries.change_gallery(%Gallery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gallery" => gallery_params}) do
    case Galleries.create_gallery(gallery_params) do
      {:ok, _gallery} ->
        conn
        |> put_flash(:info, "Gallery created successfully.")
        |> redirect(to: admin_gallery_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    gallery = Galleries.get_gallery!(id)
    changeset = Galleries.change_gallery(gallery)
    render(conn, "edit.html", gallery: gallery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gallery" => gallery_params}) do
    gallery = Galleries.get_gallery!(id)

    case Galleries.update_gallery(gallery, gallery_params) do
      {:ok, _gallery} ->
        conn
        |> put_flash(:info, "Gallery updated successfully.")
        |> redirect(to: admin_gallery_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gallery: gallery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gallery = Galleries.get_gallery!(id)
    {:ok, _gallery} = Galleries.delete_gallery(gallery)

    conn
    |> put_flash(:info, "Gallery deleted successfully.")
    |> redirect(to: admin_gallery_path(conn, :index))
  end
end
