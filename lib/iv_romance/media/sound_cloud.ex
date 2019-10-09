defmodule IvRomance.Media.SoundCloud do
  @track_regexp ~r/.+api\.soundcloud\.com\/tracks\/(.+)\&.+/U
  @playlist_regexp ~r/.+api\.soundcloud\.com\/playlists\/(.+)\&.+/U

  def parse(embed_code) do
    case parse_track(embed_code) || parse_playlist(embed_code) do
      {type, id} -> {type, id}
      _ -> nil
    end
  end

  def parse_track(embed_code) do
    case Regex.run(@track_regexp, embed_code) do
      [_, playlist_id] -> {:track, playlist_id}
      _ -> nil
    end
  end

  def parse_playlist(embed_code) do
    case Regex.run(@playlist_regexp, embed_code) do
      [_, playlist_id] -> {:playlist, playlist_id}
      _ -> nil
    end
  end
end
