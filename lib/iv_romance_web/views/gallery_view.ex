defmodule IvRomanceWeb.GalleryView do
  use IvRomanceWeb, :view

  alias IvRomance.Galleries.{Image, Upload}

  def thumb_url(%Image{filename: filename} = image), do: Upload.url({filename, image}, :thumb)

  def original_url(%Image{filename: filename} = image),
    do: Upload.url({filename, image}, :original)
end
