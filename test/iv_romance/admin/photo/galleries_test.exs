defmodule IvRomance.Admin.Photo.GalleriesTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias Ecto.{Changeset, NoResultsError, UUID}
  alias IvRomance.Admin.Photo
  alias IvRomance.Photo.Gallery

  describe "list_galleries/0" do
    test "returns empty list when there are no galleries" do
      assert Photo.list_galleries() == []
    end

    test "returns existing galleries with preloaded number of images" do
      %{gallery: gallery} = insert(:image)
      %{id: id, title: title, subtitle: subtitle} = gallery

      assert [%{id: ^id, title: ^title, subtitle: ^subtitle, images_count: 1}] =
               Photo.list_galleries()
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

  describe "create_gallery/1" do
    test "creates a gallery with valid params" do
      %{title: title} = params = params_for(:gallery)

      assert {:ok, %Gallery{title: ^title}} = Photo.create_gallery(params)
    end

    test "returns error changeset when title is blank" do
      assert {:error, %Changeset{} = changeset} =
               Photo.create_gallery(params_for(:gallery, title: ""))

      assert %{errors: [title: {"can't be blank", [validation: :required]}]} = changeset
    end
  end

  describe "update_gallery/2" do
    test "udates the gallery with valid data" do
      %{id: id} = gallery = insert(:gallery)
      %{title: title} = params = params_for(:gallery)

      assert {:ok, gallery} = Photo.update_gallery(gallery, params)
      assert %Gallery{id: ^id, title: ^title} = gallery
    end

    test "returns errors changeset with invalid data" do
      %{id: id} = gallery = insert(:gallery)

      assert {:error, %Changeset{}} = Photo.update_gallery(gallery, %{title: ""})
      assert gallery == Photo.get_gallery!(id)
    end
  end

  describe "delete_gallery/1" do
    test "deletes the gallery" do
      %{id: id} = gallery = insert(:gallery)

      assert {:ok, %Gallery{}} = Photo.delete_gallery(gallery)
      assert_raise NoResultsError, fn -> Photo.get_gallery!(id) end
    end
  end

  describe "change_gallery/1" do
    test "returns a gallery changeset" do
      gallery = insert(:gallery)

      assert %Changeset{} = Photo.change_gallery(gallery)
    end
  end
end
