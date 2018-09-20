defmodule IvRomanceWeb.Admin.MediaObjectControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, conn: assign(conn, :current_user, user)}
  end

  describe "index" do
    test "lists all media objects", %{conn: conn} do
      media_objects = insert_list(3, :media_object)

      response =
        conn
        |> get(admin_media_object_path(conn, :index))
        |> html_response(200)

      Enum.each(media_objects, fn %{
                                    provider: provider,
                                    type: type,
                                    descriptor: descriptor,
                                    title: title
                                  } ->
        assert response =~ provider
        assert response =~ type
        assert response =~ descriptor
        assert response =~ title
      end)
    end
  end

  describe "new media object" do
    test "renders form", %{conn: conn} do
      response =
        conn
        |> get(admin_media_object_path(conn, :new))
        |> html_response(200)

      assert response =~ "New media"
      assert response =~ "Embed code"
    end
  end

  describe "create media object" do
    test "redirects to index when data is valid", %{conn: conn} do
      %{
        embed_code: embed_code,
        provider: provider,
        type: type,
        descriptor: descriptor,
        title: title
      } = params_for(:media_object)

      params = %{embed_code: embed_code, title: title}

      assert admin_media_object_path(conn, :index) ==
               conn
               |> post(admin_media_object_path(conn, :create), media_object: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_media_object_path(conn, :index))
               |> html_response(200)

      assert response =~ provider
      assert response =~ type
      assert response =~ descriptor
      assert response =~ title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      assert response =
               conn
               |> post(admin_media_object_path(conn, :create), media_object: %{})
               |> html_response(200)

      assert response =~ "New media"
    end
  end

  describe "edit media object" do
    test "renders form for editing chosen media object", %{conn: conn} do
      media_object = insert(:media_object)

      assert response =
               conn
               |> get(admin_media_object_path(conn, :edit, media_object))
               |> html_response(200)

      assert response =~ "Edit media"
      refute response =~ "Embed code"
    end
  end

  describe "update media object" do
    test "redirects to the updated media object when data is valid", %{conn: conn} do
      %{provider: provider, type: type, descriptor: descriptor} =
        media_object = insert(:media_object)

      %{title: new_title} = params = params_for(:media_object)

      assert admin_media_object_path(conn, :index) ==
               conn
               |> put(admin_media_object_path(conn, :update, media_object), media_object: params)
               |> redirected_to()

      assert response =
               conn
               |> get(admin_media_object_path(conn, :index))
               |> html_response(200)

      assert response =~ provider
      assert response =~ type
      assert response =~ descriptor
      assert response =~ new_title
    end
  end

  describe "delete media object" do
    test "deletes chosen media object", %{conn: conn} do
      %{descriptor: descriptor} = media_object = insert(:media_object)

      assert admin_media_object_path(conn, :index) ==
               conn
               |> delete(admin_media_object_path(conn, :delete, media_object))
               |> redirected_to()

      assert response =
               conn
               |> get(admin_media_object_path(conn, :index))
               |> html_response(200)

      refute response =~ descriptor
    end
  end
end
