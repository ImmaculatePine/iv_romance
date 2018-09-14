defmodule IvRomanceWeb.Admin.ImageView do
  use IvRomanceWeb, :view

  alias IvRomanceWeb.GalleryView

  defdelegate thumb_url(image), to: GalleryView
end
