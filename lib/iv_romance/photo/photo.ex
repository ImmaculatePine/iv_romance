defmodule IvRomance.Photo do
  import Ecto.Query, warn: false

  alias IvRomance.Repo
  alias IvRomance.Photo.{Gallery, Image}

  def list_galleries, do: Repo.all(Gallery)

  def get_gallery!(id), do: Repo.one!(from(Gallery, where: [id: ^id]))

  def list_images(gallery_id) do
    from(Image, where: [gallery_id: ^gallery_id], order_by: [asc: :position])
    |> Repo.all()
  end
end
