defmodule IvRomance.Media.ParserTest do
  use IvRomance.DataCase, async: true

  alias IvRomance.Media.Parser

  @video_url "https://www.youtube.com/watch?v=GpSuIF_8_r8"
  @track_embed_code ~s(<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/501765027&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe>)
  @playlist_embed_code ~s(<iframe width="100%" height="450" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/605836044&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe>)
  @random_string "random"

  describe "to_attrs/1" do
    test "returns attrs for valid SoundCloud track embed code" do
      assert %{provider: "sound_cloud", type: "track", descriptor: "501765027"} =
               Parser.to_attrs(@track_embed_code)
    end

    test "returns attrs for valid SoundCloud playlist embed code" do
      assert %{provider: "sound_cloud", type: "playlist", descriptor: "605836044"} =
               Parser.to_attrs(@playlist_embed_code)
    end

    test "returns attrs for valid Youtube embed code" do
      assert %{provider: "youtube", type: "video", descriptor: "GpSuIF_8_r8"} =
               Parser.to_attrs(@video_url)
    end

    test "returns nil for random string" do
      refute Parser.to_attrs(@random_string)
    end
  end
end
