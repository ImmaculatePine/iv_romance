defmodule IvRomance.Uploads.S3.Adapter.Aws do
  @behaviour IvRomance.Uploads.S3.Adapter
  def request(operation), do: ExAws.request(operation)
end
