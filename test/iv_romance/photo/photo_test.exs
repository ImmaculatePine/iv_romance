defmodule IvRomance.PhotoTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Photo
  alias Ecto.{UUID, NoResultsError}

  describe "list_galleries/0" do
    test "returns empty list when there are no galleries" do
      assert Photo.list_galleries() == []
    end

    test "returns existing galleries" do
      gallery = insert(:gallery)
      assert Photo.list_galleries() == [gallery]
    end
  end

  describe "get_gallery!/1" do
    test "returns the gallery with given id" do
      %{id: id} = gallery = insert(:gallery)
      assert Photo.get_gallery!(id) == gallery
    end

    test "raises NoResultsError when gallery does not exist" do
      assert_raise NoResultsError, fn -> Photo.get_gallery!(UUID.generate()) end
    end
  end

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

      assert [%{id: ^id_1, filename: ^filename_1}, %{id: ^id_2, filename: ^filename_2}] =
               Photo.list_images(gallery_id)
    end
  end
end
