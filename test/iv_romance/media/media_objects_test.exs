defmodule IvRomance.Media.MediaObjectsTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Media
  alias IvRomance.Media.Object, as: MediaObject

  describe "list_media_objects/0" do
    test "returns list of existing media objects" do
      %{id: id} = insert(:media_object)

      assert [%MediaObject{id: ^id}] = Media.list_media_objects()
    end
  end
end
