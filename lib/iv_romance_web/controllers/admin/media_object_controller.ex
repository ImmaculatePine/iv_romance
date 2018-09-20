defmodule IvRomanceWeb.Admin.MediaObjectController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Media
  alias IvRomance.Media.Object, as: MediaObject

  def index(conn, _params) do
    media_objects = Media.list_media_objects()
    render(conn, "index.html", media_objects: media_objects)
  end

  def new(conn, _params) do
    changeset = Media.change_media_object(%MediaObject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"media_object" => media_object_params}) do
    case Media.create_media_object(media_object_params) do
      {:ok, _media_object} ->
        conn
        |> put_flash(:info, "Media created successfully.")
        |> redirect(to: admin_media_object_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    media_object = Media.get_media_object!(id)
    changeset = Media.change_media_object(media_object)
    render(conn, "edit.html", media_object: media_object, changeset: changeset)
  end

  def update(conn, %{"id" => id, "media_object" => media_object_params}) do
    media_object = Media.get_media_object!(id)

    case Media.update_media_object(media_object, media_object_params) do
      {:ok, _media_object} ->
        conn
        |> put_flash(:info, "Media updated successfully.")
        |> redirect(to: admin_media_object_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", media_object: media_object, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    media_object = Media.get_media_object!(id)
    {:ok, _media_object} = Media.delete_media_object(media_object)

    conn
    |> put_flash(:info, "Media deleted successfully.")
    |> redirect(to: admin_media_object_path(conn, :index))
  end
end
