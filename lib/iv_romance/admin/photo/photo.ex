defmodule IvRomance.Admin.Photo do
  import Ecto.Query, warn: false

  alias IvRomance.Admin.Photo.Uploader
  alias IvRomance.Photo.{Gallery, Image}
  alias IvRomance.Repo

  def list_galleries do
    from(gallery in Gallery,
      left_join: image in assoc(gallery, :images),
      group_by: gallery.id,
      select: %{gallery | images_count: count(image.id)}
    )
    |> Repo.all()
  end

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

  def list_images(gallery_id),
    do: Repo.all(from(Image, where: [gallery_id: ^gallery_id], order_by: [asc: :position]))

  def get_image!(id), do: Repo.one!(from(Image, where: [id: ^id]))

  defdelegate upload_image(attrs), to: Uploader

  defdelegate delete_image(image), to: Uploader
end
