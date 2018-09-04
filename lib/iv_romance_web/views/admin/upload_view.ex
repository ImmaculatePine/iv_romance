defmodule IvRomanceWeb.Admin.UploadView do
  use IvRomanceWeb, :view

  def file_name(url) do
    url
    |> String.split("/")
    |> List.last()
  end
end
