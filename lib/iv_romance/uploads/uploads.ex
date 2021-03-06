defmodule IvRomance.Uploads do
  alias IvRomance.Uploads.S3

  def list_uploads do
    case S3.list() do
      {:ok, uploads} -> uploads
      _ -> []
    end
  end

  def create_upload(file_name, file_path) do
    with {:ok, file_binary} <- File.read(file_path) do
      S3.upload(file_name, file_binary)
    end
  end

  def delete_upload(file_name), do: S3.delete(file_name)
end
