defmodule IvRomance.Galleries.Upload do
  use Arc.Definition

  @versions [:original, :thumb]
  @extensions ~w(.jpg .jpeg .png)

  def validate({%{file_name: file_name}, _}) do
    Enum.member?(@extensions, file_name |> String.downcase() |> Path.extname())
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250 -gravity center"}
  end

  def filename(version, {_file, _scope}), do: version

  def storage_dir(_version, {_file, scope}), do: "uploads/images/#{scope.id}"
end
