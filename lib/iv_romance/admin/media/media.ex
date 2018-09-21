defmodule IvRomance.Admin.Media do
  import Ecto.Query, warn: false

  alias IvRomance.Repo
  alias IvRomance.Media.Object, as: MediaObject

  def list_media_objects, do: Repo.all(MediaObject)

  def get_media_object!(id), do: Repo.get!(MediaObject, id)

  def create_media_object(attrs \\ %{}) do
    %MediaObject{}
    |> MediaObject.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_media_object(%MediaObject{} = media_object, attrs) do
    media_object
    |> MediaObject.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_media_object(%MediaObject{} = media_object) do
    Repo.delete(media_object)
  end

  def change_media_object(%MediaObject{} = media_object) do
    MediaObject.update_changeset(media_object, %{})
  end
end
