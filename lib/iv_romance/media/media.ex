defmodule IvRomance.Media do
  use Ecto.Schema

  alias IvRomance.Repo
  alias IvRomance.Media.Object, as: MediaObject

  def list_media_objects, do: Repo.all(MediaObject)
end
