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
    case SoundCloud.parse(embed_code) do
      {type, descriptor} -> {:ok, {"sound_cloud", type, descriptor}}
      _ -> embed_code
    end
  end

  defp maybe_parse_youtube({:ok, result}), do: {:ok, result}

  defp maybe_parse_youtube(embed_code) do
    case Youtube.parse(embed_code) do
      {type, descriptor} -> {:ok, {"youtube", type, descriptor}}
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
