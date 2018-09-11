defmodule IvRomance.Admin.Galleries.GalleriesTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Galleries.Gallery
  alias IvRomance.Admin.Galleries
  alias Ecto.{Changeset, NoResultsError, UUID}

  describe "list_galleries/0" do
    test "returns empty list when there are no galleries" do
      assert Galleries.list_galleries() == []
    end

    test "returns existing galleries" do
      gallery = insert(:gallery)
      assert Galleries.list_galleries() == [gallery]
    end
  end

  describe "get_gallery!/1" do
    test "returns the gallery with given id" do
      %{id: id} = gallery = insert(:gallery)
      assert Galleries.get_gallery!(id) == gallery
    end

    test "raises NoResultsError when gallery does not exist" do
      assert_raise NoResultsError, fn -> Galleries.get_gallery!(UUID.generate()) end
    end
  end

  describe "create_gallery/1" do
    test "creates a gallery with valid params" do
      %{title: title} = params = params_for(:gallery)

      assert {:ok, %Gallery{title: ^title}} = Galleries.create_gallery(params)
    end

    test "returns error changeset when title is blank" do
      assert {:error, %Changeset{} = changeset} =
               Galleries.create_gallery(params_for(:gallery, title: ""))

      assert %{errors: [title: {"can't be blank", [validation: :required]}]} = changeset
    end
  end

  describe "update_gallery/2" do
    test "udates the gallery with valid data" do
      %{id: id} = gallery = insert(:gallery)
      %{title: title} = params = params_for(:gallery)

      assert {:ok, gallery} = Galleries.update_gallery(gallery, params)
      assert %Gallery{id: ^id, title: ^title} = gallery
    end

    test "returns errors changeset with invalid data" do
      %{id: id} = gallery = insert(:gallery)

      assert {:error, %Changeset{}} = Galleries.update_gallery(gallery, %{title: ""})
      assert gallery == Galleries.get_gallery!(id)
    end
  end

  describe "delete_gallery/1" do
    test "deletes the gallery" do
      %{id: id} = gallery = insert(:gallery)

      assert {:ok, %Gallery{}} = Galleries.delete_gallery(gallery)
      assert_raise NoResultsError, fn -> Galleries.get_gallery!(id) end
    end
  end

  describe "change_gallery/1" do
    test "returns a gallery changeset" do
      gallery = insert(:gallery)

      assert %Changeset{} = Galleries.change_gallery(gallery)
    end
  end
end
