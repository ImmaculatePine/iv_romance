defmodule IvRomance.Uploads do
  alias IvRomance.Uploads.S3

  def list_uploads, do: S3.list()

  def create_upload(file_path) do
    with {:ok, file_binary} <- File.read(file_path),
         file_name = generate(file_path) do
      S3.upload(file_name, file_binary)
    end
  end

  def delete_upload(file_name), do: S3.delete(file_name)

  defp generate(file_path), do: Ecto.UUID.generate() <> Path.extname(file_path)
end
