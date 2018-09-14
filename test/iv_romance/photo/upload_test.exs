defmodule IvRomance.Photo.UploadTest do
  use IvRomance.DataCase

  alias IvRomance.Photo.Upload

  describe "validate/1" do
    test "returns true for allowed extensions" do
      Enum.each(~w(.jpg .jpeg .png .JPG .JPEG .PNG), fn extension ->
        assert Upload.validate({
                 %{file_name: "image#{extension}"},
                 %{}
               })
      end)
    end

    test "returns false for not allowed extensions" do
      Enum.each(~w(.gif .GIF .txt .TXT), fn extension ->
        refute Upload.validate({
                 %{file_name: "image#{extension}"},
                 %{}
               })
      end)
    end
  end

  describe "filename/2" do
    test "returns version as the file name" do
      file = %{file_name: "image.png"}
      scope = %{id: "1"}

      assert Upload.filename(:original, {file, scope}) == :original
      assert Upload.filename(:thumb, {file, scope}) == :thumb
    end
  end

  describe "storage_dir/2" do
    test "returns name of the directory where to store file" do
      file = %{file_name: "image.png"}
      scope = %{id: "1"}

      assert Upload.storage_dir(:original, {file, scope}) == "uploads/images/1"
      assert Upload.storage_dir(:thumb, {file, scope}) == "uploads/images/1"
    end
  end
end
