defmodule IvRomance.Media.SoundCloud do
  @track_regexp ~r/.+api\.soundcloud\.com\/tracks\/(.+)\&.+/U
  @playlist_regexp ~r/.+api\.soundcloud\.com\/playlists\/(.+)\&.+/U

  def parse(embed_code) do
    with {type, id} <- parse_track(embed_code) || parse_playlist(embed_code) do
      {type, id}
    else
      _ -> nil
    end
  end

  def parse_track(embed_code) do
    with [_, playlist_id] <- Regex.run(@track_regexp, embed_code) do
      {:track, playlist_id}
    else
      _ -> nil
    end
  end

  def parse_playlist(embed_code) do
    with [_, playlist_id] <- Regex.run(@playlist_regexp, embed_code) do
      {:playlist, playlist_id}
    else
      _ -> nil
    end
  end
end
