defmodule IvRomance.Admin.Photo.UploaderTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias Ecto.{NoResultsError, UUID}
  alias IvRomance.Admin.Photo
  alias IvRomance.Photo.Image
  alias IvRomance.Repo

  setup do
    on_exit(fn ->
      File.rm_rf!("uploads")
    end)

    gallery = insert(:gallery)
    upload = %Plug.Upload{filename: "image.png", path: "test/fixtures/image.png"}
    {:ok, gallery: gallery, upload: upload}
  end

  describe "upload_image/2" do
    test "creates database record and uploads file to storage", %{
      gallery: %{id: gallery_id},
      upload: upload
    } do
      assert {:ok, image} =
               Photo.upload_image(%{gallery_id: gallery_id, position: 1, file: upload})

      assert %Image{id: id, filename: "image.png", gallery_id: ^gallery_id} = image
      assert File.exists?("uploads/images/#{id}/original.png")
      assert File.exists?("uploads/images/#{id}/thumb.png")
    end

    test "returns validation error when %Image{} was not created", %{upload: upload} do
      gallery_id = UUID.generate()

      assert {:error, error} =
               Photo.upload_image(%{gallery_id: gallery_id, position: 1, file: upload})

      assert %{errors: [gallery_id: {"does not exist", []}]} = error
    end

    test "returns error and removes database record when upload failed", %{
      gallery: %{id: gallery_id}
    } do
      upload = %Plug.Upload{filename: "image.png", path: "test/fixtures/not-existing.png"}
      images_count = Repo.aggregate(Image, :count, :id)

      assert {:error, :invalid_file_path} =
               Photo.upload_image(%{gallery_id: gallery_id, position: 1, file: upload})

      assert Repo.aggregate(Image, :count, :id) == images_count
    end
  end

  describe "delete_image/1" do
    test "removes both files and database record", %{gallery: %{id: gallery_id}, upload: upload} do
      assert {:ok, %{id: id} = image} =
               Photo.upload_image(%{gallery_id: gallery_id, position: 1, file: upload})

      assert {:ok, %Image{id: ^id}} = Photo.delete_image(image)
      assert_raise NoResultsError, fn -> Photo.get_image!(id) end
      refute File.exists?("uploads/images/#{id}/original.png")
      refute File.exists?("uploads/images/#{id}/thumb.png")
    end
  end
end
