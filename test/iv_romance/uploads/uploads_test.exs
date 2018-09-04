defmodule IvRomance.UploadsTest do
  use IvRomance.DataCase

  import Mox

  alias IvRomance.Uploads
  alias IvRomance.Uploads.S3.Adapter.Mock

  setup :verify_on_exit!

  describe "list_uploads/0" do
    test "returns list of uploaded files on success" do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: %{
             common_prefixes: [],
             contents: [
               %{
                 e_tag: "\"0df961a9aa8c9d7f4d8db8777e8c48b3\"",
                 key: "uploaded-image.png",
                 last_modified: "2018-09-02T21:41:17.000Z",
                 owner: nil,
                 size: "137",
                 storage_class: "STANDARD"
               }
             ],
             is_truncated: "false",
             marker: "",
             max_keys: "1000",
             name: "iv-romance-uploads-test",
             next_marker: "",
             prefix: ""
           },
           headers: [],
           status_code: 200
         }}
      end)

      assert Uploads.list_uploads() == [
               "https://s3.eu-central-1.amazonaws.com/iv-romance-uploads-test/uploaded-image.png"
             ]
    end

    test "returns empty array on failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)
      assert Uploads.list_uploads() == []
    end
  end

  describe "create_upload/2" do
    test "returns URL of the uploaded file on success" do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: "",
           headers: [],
           status_code: 200
         }}
      end)

      file_name = "new-image.png"
      file_path = "test/fixtures/image.png"

      assert Uploads.create_upload(file_name, file_path) ==
               {:ok,
                "https://s3.eu-central-1.amazonaws.com/iv-romance-uploads-test/new-image.png"}
    end

    test "returns error when file does not exist" do
      file_name = "new-image.png"
      file_path = "test/fixtures/unknown.png"

      assert Uploads.create_upload(file_name, file_path) == {:error, :enoent}
    end

    test "returns error on AWS failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)

      file_name = "new-image.png"
      file_path = "test/fixtures/image.png"

      assert Uploads.create_upload(file_name, file_path) == {:error, :access_denied}
    end
  end

  describe "delete/1" do
    test "returns :ok on success" do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: "",
           headers: [],
           status_code: 204
         }}
      end)

      assert Uploads.delete_upload("uploaded-image.png") == :ok
    end

    test "returns error on failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)

      assert Uploads.delete_upload("uploaded-image.png") == {:error, :access_denied}
    end
  end
end
