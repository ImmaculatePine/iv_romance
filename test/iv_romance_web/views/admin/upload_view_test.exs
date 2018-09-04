defmodule IvRomanceWeb.Admin.UploadViewTest do
  use IvRomanceWeb.ConnCase, async: true

  alias IvRomanceWeb.Admin.UploadView

  describe "file_name/1" do
    test "extracts file name from the URL" do
      assert UploadView.file_name("http://example.com/image.png") == "image.png"
      assert UploadView.file_name("http://example.com/test/image.png") == "image.png"
      assert UploadView.file_name("http://example.com/test/image") == "image"
    end
  end
end
