defmodule IvRomance.Admin.Galleries do
  import Ecto.Query, warn: false

  alias IvRomance.Repo
  alias IvRomance.Admin.Galleries.Uploader
  alias IvRomance.Galleries.{Gallery, Image}

  def list_galleries, do: Repo.all(Gallery)

  def get_gallery!(id), do: Repo.one!(from(Gallery, where: [id: ^id]))

  def create_gallery(attrs \\ %{}) do
    %Gallery{}
    |> Gallery.changeset(attrs)
    |> Repo.insert()
  end

  def update_gallery(%Gallery{} = gallery, attrs) do
    gallery
    |> Gallery.changeset(attrs)
    |> Repo.update()
  end

  def delete_gallery(%Gallery{} = gallery), do: Repo.delete(gallery)

  def change_gallery(%Gallery{} = gallery), do: Gallery.changeset(gallery, %{})

  def list_images(gallery_id), do: Repo.all(from(Image, where: [gallery_id: ^gallery_id]))

  def get_image!(id), do: Repo.one!(from(Image, where: [id: ^id]))

  defdelegate upload_image(gallery_id, upload), to: Uploader

  defdelegate delete_image(image), to: Uploader
end
