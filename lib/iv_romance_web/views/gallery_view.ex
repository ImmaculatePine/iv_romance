defmodule IvRomanceWeb.GalleryView do
  use IvRomanceWeb, :view

  alias IvRomance.Photo.{Gallery, Image, Upload}

  def chunks(galleries), do: Enum.chunk_every(galleries, 2)

  def has_subtitle?(%Gallery{subtitle: nil}), do: false
  def has_subtitle?(%Gallery{subtitle: ""}), do: false
  def has_subtitle?(%Gallery{subtitle: _}), do: true

  def upload_url(%Image{filename: filename} = image, version) do
    Upload.url({filename, image}, version)
  end
end
