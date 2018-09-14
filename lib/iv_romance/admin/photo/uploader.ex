defmodule IvRomance.Admin.Photo.Uploader do
  import Ecto.Query, warn: false

  alias IvRomance.Repo
  alias IvRomance.Photo.{Image, Upload}

  def upload_image(gallery_id, %Plug.Upload{} = upload) do
    with {:ok, image} <- create_record(%{gallery_id: gallery_id}),
         {:ok, filename} <- store_file(upload, image),
         {:ok, image} <- set_filename(image, filename) do
      {:ok, image}
    else
      {:error, :create_record, error} ->
        {:error, error}

      {:error, {:store_file, image}, error} ->
        delete_record(image)
        {:error, error}

      {:error, {:set_filename, image, filename}, error} ->
        delete_file(filename, image)
        delete_record(image)
        {:error, error}
    end
  end

  def delete_image(%Image{filename: filename} = image) do
    with :ok = delete_file(filename, image),
         {:ok, image} <- delete_record(image) do
      {:ok, image}
    end
  end

  defp create_record(attrs) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
    |> maybe_wrap_error(:create_record)
  end

  defp store_file(upload, image) do
    {upload, image}
    |> Upload.store()
    |> maybe_wrap_error({:store_file, image})
  end

  defp set_filename(%Image{} = image, filename) do
    image
    |> Image.changeset(%{filename: filename})
    |> Repo.update()
    |> maybe_wrap_error({:set_filename, image, filename})
  end

  def delete_record(%Image{} = image), do: Repo.delete(image)

  def delete_file(filename, image), do: Upload.delete({filename, image})

  defp maybe_wrap_error({:ok, result}, _context), do: {:ok, result}
  defp maybe_wrap_error({:error, error}, context), do: {:error, context, error}
end
