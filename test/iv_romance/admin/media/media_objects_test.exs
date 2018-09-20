defmodule IvRomance.Admin.Media.MediaObjectsTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Admin.Media
  alias IvRomance.Media.Object, as: MediaObject
  alias Ecto.{Changeset, NoResultsError, UUID}

  describe "list_media_objects/0" do
    test "returns list of existing media objects" do
      %{id: id} = insert(:media_object)

      assert [%MediaObject{id: ^id}] = Media.list_media_objects()
    end
  end

  describe "get_media_object!/1" do
    test "returns the media object with given id" do
      %{id: id} = insert(:media_object)

      assert %MediaObject{id: ^id} = Media.get_media_object!(id)
    end

    test "raises NoResultsError when media object does not exist" do
      assert_raise NoResultsError, fn -> Media.get_media_object!(UUID.generate()) end
    end
  end

  describe "create_media_object/1" do
    test "creates a media object with valid params" do
      %{
        provider: provider,
        type: type,
        descriptor: descriptor,
        embed_code: embed_code,
        title: title
      } = params_for(:media_object)

      params = %{embed_code: embed_code, title: title}

      assert {:ok,
              %MediaObject{
                provider: ^provider,
                type: ^type,
                descriptor: ^descriptor,
                title: ^title
              }} = Media.create_media_object(params)
    end

    test "returns error changeset when embed code was not parsed" do
      assert {:error, %Changeset{} = changeset} =
               Media.create_media_object(%{embed_code: "random"})

      assert %{
               errors: [
                 provider: {"can't be blank", [validation: :required]},
                 type: {"can't be blank", [validation: :required]},
                 descriptor: {"can't be blank", [validation: :required]}
               ]
             } = changeset
    end
  end

  describe "update_media_object/2" do
    test "updates only title of media object" do
      %{id: id, provider: provider, type: type, descriptor: descriptor} =
        media_object = insert(:media_object)

      %{title: new_title} = params = params_for(:media_object)

      assert {:ok, media_object} = Media.update_media_object(media_object, params)

      assert %MediaObject{
               id: ^id,
               provider: ^provider,
               type: ^type,
               descriptor: ^descriptor,
               title: ^new_title
             } = media_object
    end
  end

  describe "delete_media_object/1" do
    test "deletes the media object" do
      %{id: id} = media_object = insert(:media_object)

      assert {:ok, %MediaObject{}} = Media.delete_media_object(media_object)
      assert_raise NoResultsError, fn -> Media.get_media_object!(id) end
    end
  end

  describe "change_media_object/1" do
    test "returns a media object changeset" do
      media_object = insert(:media_object)

      assert %Changeset{} = Media.change_media_object(media_object)
    end
  end
end
