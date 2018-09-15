defmodule IvRomanceWeb.GalleryViewTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  alias IvRomanceWeb.GalleryView

  describe "chunks/1" do
    test "splits list into chunks" do
      assert GalleryView.chunks([1, 2, 3, 4, 5, 6, 7]) == [[1, 2], [3, 4], [5, 6], [7]]
    end
  end

  describe "has_subtitle?/1" do
    test "returns true for gallery with subtitle" do
      assert :gallery
             |> insert(subtitle: "Test")
             |> GalleryView.has_subtitle?()
    end

    test "returns false for gallery without subtitle" do
      refute :gallery
             |> insert(subtitle: "")
             |> GalleryView.has_subtitle?()

      refute :gallery
             |> insert(subtitle: nil)
             |> GalleryView.has_subtitle?()
    end
  end

  describe "upload_url/1" do
    test "returns url to the selected image version" do
      %{id: id} = image = insert(:image, filename: "image.png")
      assert GalleryView.upload_url(image, :original) == "/uploads/images/#{id}/original.png"
      assert GalleryView.upload_url(image, :thumb) == "/uploads/images/#{id}/thumb.png"
    end
  end
end
