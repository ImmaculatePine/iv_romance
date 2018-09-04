defmodule IvRomance.Uploads.S3 do
  @region Application.get_env(:ex_aws, :region)
  @bucket Application.get_env(:iv_romance, __MODULE__)[:bucket]
  @adapter Application.get_env(:iv_romance, __MODULE__)[:adapter]
  @s3_url "https://s3.#{@region}.amazonaws.com/#{@bucket}"

  def list do
    @bucket
    |> ExAws.S3.list_objects()
    |> @adapter.request()
    |> decorate_list()
  end

  defp decorate_list({:ok, %{body: %{contents: uploads}}}) do
    {:ok, Enum.map(uploads, fn %{key: key} -> build_url(key) end)}
  end

  defp decorate_list(error), do: error

  def upload(file_name, file_binary) do
    @bucket
    |> ExAws.S3.put_object(file_name, file_binary)
    |> @adapter.request()
    |> decorate_upload(file_name)
  end

  def decorate_upload({:ok, _}, file_name), do: {:ok, build_url(file_name)}
  def decorate_upload(error, _file_name), do: error

  def delete(file_name) do
    @bucket
    |> ExAws.S3.delete_object(file_name)
    |> @adapter.request
    |> decorate_delete()
  end

  defp decorate_delete({:ok, _}), do: :ok
  defp decorate_delete(error), do: error

  defp build_url(file_name), do: @s3_url <> "/" <> file_name
end
