defmodule IvRomance.Media.Parser do
  alias IvRomance.Media.SoundCloud
  alias IvRomance.Media.Youtube

  def to_attrs(embed_code) do
    embed_code
    |> maybe_parse_sound_cloud()
    |> maybe_parse_youtube()
    |> build_attrs()
  end

  defp maybe_parse_sound_cloud({:ok, result}), do: {:ok, result}

  defp maybe_parse_sound_cloud(embed_code) do
    with {type, descriptor} <- SoundCloud.parse(embed_code) do
      {:ok, {"sound_cloud", type, descriptor}}
    else
      _ -> embed_code
    end
  end

  defp maybe_parse_youtube({:ok, result}), do: {:ok, result}

  defp maybe_parse_youtube(embed_code) do
    with {type, descriptor} <- Youtube.parse(embed_code) do
      {:ok, {"youtube", type, descriptor}}
    else
      _ -> embed_code
    end
  end

  defp build_attrs({:ok, {provider, type, descriptor}}) do
    %{
      provider: provider,
      type: Atom.to_string(type),
      descriptor: descriptor
    }
  end

  defp build_attrs(_), do: nil
end
