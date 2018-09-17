defmodule IvRomanceWeb.Admin.ImageView do
  use IvRomanceWeb, :view

  alias IvRomanceWeb.GalleryView

  defdelegate upload_url(image, version), to: GalleryView

  def render("index.json", %{images: images}),
    do: render_many(images, __MODULE__, "image.json", as: :image)

  def render("image.json", %{image: image}) do
    image
    |> Map.take([:id, :position])
    |> Map.put(:thumb_url, upload_url(image, :thumb))
  end
end
