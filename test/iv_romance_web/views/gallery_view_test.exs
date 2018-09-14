defmodule IvRomanceWeb.GalleryViewTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  alias IvRomanceWeb.GalleryView

  describe "thumb_url/1" do
    test "returns url to the image thumbnail" do
      %{id: id} = image = insert(:image, filename: "image.png")
      assert GalleryView.thumb_url(image) == "/uploads/images/#{id}/thumb.png"
    end
  end

  describe "original_url/1" do
    test "returns url to the image thumbnail" do
      %{id: id} = image = insert(:image, filename: "image.png")
      assert GalleryView.original_url(image) == "/uploads/images/#{id}/original.png"
    end
  end
end
