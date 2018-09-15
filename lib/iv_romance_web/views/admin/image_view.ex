defmodule IvRomanceWeb.Admin.ImageView do
  use IvRomanceWeb, :view

  alias IvRomanceWeb.GalleryView

  defdelegate upload_url(image, version), to: GalleryView
end
