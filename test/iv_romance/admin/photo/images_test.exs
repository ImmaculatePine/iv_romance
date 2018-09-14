defmodule IvRomance.Admin.Photo.ImagesTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Photo.Image
  alias IvRomance.Admin.Photo
  alias Ecto.{NoResultsError, UUID}

  describe "list_images/1" do
    test "returns empty list when there is no gallery with such id" do
      assert Photo.list_images(UUID.generate()) == []
    end

    test "returns empty list when there are no images in the gallery" do
      %{id: gallery_id} = insert(:gallery)

      assert Photo.list_images(gallery_id) == []
    end

    test "returns existing images in the gallery" do
      %{id: gallery_id} = gallery = insert(:gallery)
      insert(:image)

      [%{id: id_1, filename: filename_1}, %{id: id_2, filename: filename_2}] =
        insert_list(2, :image, gallery: gallery)

      assert [%{id: ^id_2, filename: ^filename_2}, %{id: ^id_1, filename: ^filename_1}] =
               Photo.list_images(gallery_id)
    end
  end

  describe "get_image!/1" do
    test "returns the image with given id" do
      %{id: id, filename: filename, gallery_id: gallery_id} = insert(:image)

      assert %Image{id: ^id, filename: ^filename, gallery_id: ^gallery_id} = Photo.get_image!(id)
    end

    test "raises NoResultsError when image does not exist" do
      assert_raise NoResultsError, fn -> Photo.get_image!(UUID.generate()) end
    end
  end
end
