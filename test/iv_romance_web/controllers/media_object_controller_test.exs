defmodule IvRomanceWeb.MediaObjectControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, conn: assign(conn, :current_user, user)}
  end

  describe "index" do
    test "lists all media objects", %{conn: conn} do
      %{descriptor: playlist_id} =
        insert(:media_object, provider: "sound_cloud", type: "playlist")

      %{descriptor: track_id} = insert(:media_object, provider: "sound_cloud", type: "track")

      response =
        conn
        |> get(media_object_path(conn, :index))
        |> html_response(200)

      assert response =~ playlist_id
      assert response =~ track_id
    end
  end
end
