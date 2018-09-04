defmodule IvRomance.Uploads.S3.Adapter do
  @typep operation :: ExAws.Operation.t()
  @callback request(operation) :: {:ok, term} | {:error, term}
end
