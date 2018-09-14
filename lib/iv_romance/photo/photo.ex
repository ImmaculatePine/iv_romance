defmodule IvRomance.Photo do
  import Ecto.Query, warn: false

  alias IvRomance.Repo
  alias IvRomance.Photo.Gallery

  def list_galleries, do: Repo.all(Gallery)

  def get_gallery!(id) do
    from(
      Gallery,
      where: [id: ^id],
      preload: :images
    )
    |> Repo.one!()
  end
end
