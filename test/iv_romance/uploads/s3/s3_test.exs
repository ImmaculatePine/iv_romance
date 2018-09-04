defmodule IvRomance.Uploads.S3Test do
  use IvRomance.DataCase

  import Mox

  alias IvRomance.Uploads.S3
  alias IvRomance.Uploads.S3.Adapter.Mock

  setup :verify_on_exit!

  describe "list/0" do
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

      assert S3.list() ==
               {:ok,
                [
                  "https://s3.eu-central-1.amazonaws.com/iv-romance-uploads-test/uploaded-image.png"
                ]}
    end

    test "returns error on failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)
      assert S3.list() == {:error, :access_denied}
    end
  end

  describe "upload/2" do
    test "returns URL of the uploaded file on success" do
      expect(Mock, :request, fn _ ->
        {:ok,
         %{
           body: "",
           headers: [],
           status_code: 200
         }}
      end)

      file_name = "uploaded-image.png"
      file_binary = File.read!("test/fixtures/image.png")

      assert S3.upload(file_name, file_binary) ==
               {:ok,
                "https://s3.eu-central-1.amazonaws.com/iv-romance-uploads-test/uploaded-image.png"}
    end

    test "returns error on failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)

      file_name = "uploaded-image.png"
      file_binary = File.read!("test/fixtures/image.png")

      assert S3.upload(file_name, file_binary) == {:error, :access_denied}
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

      assert S3.delete("uploaded-image.png") == :ok
    end

    test "returns error on failure" do
      expect(Mock, :request, fn _ -> {:error, :access_denied} end)

      assert S3.delete("uploaded-image.png") == {:error, :access_denied}
    end
  end
end
