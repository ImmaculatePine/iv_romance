defmodule IvRomance.Media do
  use Ecto.Schema

  alias IvRomance.Media.Object, as: MediaObject
  alias IvRomance.Repo

  def list_media_objects, do: Repo.all(MediaObject)
end
