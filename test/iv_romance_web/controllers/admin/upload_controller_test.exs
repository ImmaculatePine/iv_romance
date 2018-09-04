defmodule IvRomanceWeb.Admin.UploadControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory
  import Mox

  alias IvRomance.Uploads.S3.Adapter.Mock

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, conn: assign(conn, :current_user, user)}
  end

  describe "index" do
    test "lists all uploads", %{conn: conn} do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: %{
             contents: [
               %{key: "image-1.png"},
               %{key: "image-2.png"},
               %{key: "image-3.png"}
             ]
           }
         }}
      end)

      response =
        conn
        |> get(admin_upload_path(conn, :index))
        |> html_response(200)

      assert response =~ "image-1.png"
      assert response =~ "image-2.png"
      assert response =~ "image-3.png"
    end
  end

  describe "create upload" do
    test "redirects to index with success when upload succeed", %{conn: conn} do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: "",
           headers: [],
           status_code: 200
         }}
      end)

      upload = %Plug.Upload{path: "test/fixtures/image.png", filename: "image.png"}
      conn = post(conn, admin_upload_path(conn, :create), upload: %{file: upload})

      assert redirected_to(conn) == admin_upload_path(conn, :index)
      assert get_flash(conn, :info)
    end

    test "redirects to index with error when upload failed", %{conn: conn} do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)

      upload = %Plug.Upload{path: "test/fixtures/image.png", filename: "image.png"}
      conn = post(conn, admin_upload_path(conn, :create), upload: %{file: upload})

      assert redirected_to(conn) == admin_upload_path(conn, :index)
      assert get_flash(conn, :error)
    end
  end

  describe "delete upload" do
    test "redirects to index", %{conn: conn} do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: "",
           headers: [],
           status_code: 204
         }}
      end)

      assert admin_upload_path(conn, :index) ==
               conn
               |> delete(admin_upload_path(conn, :delete, "image.png"))
               |> redirected_to()
    end
  end
end
