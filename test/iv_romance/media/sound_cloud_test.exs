defmodule IvRomance.Media.SoundCloudTest do
  use IvRomance.DataCase, async: true

  alias IvRomance.Media.SoundCloud

  @track_embed_code ~s(<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/501765027&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe>)
  @playlist_embed_code ~s(<iframe width="100%" height="450" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/605836044&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe>)
  @random_string "random"

  describe "parse/1" do
    test "returns parsed id and type for track embed code" do
      assert {:track, "501765027"} = SoundCloud.parse(@track_embed_code)
    end

    test "returns id for playlist embed code" do
      assert {:playlist, "605836044"} = SoundCloud.parse(@playlist_embed_code)
    end

    test "returns nil for random string" do
      refute SoundCloud.parse(@random_string)
    end
  end

  describe "parse_track/1" do
    test "returns parsed id and type for track embed code" do
      assert {:track, "501765027"} = SoundCloud.parse_track(@track_embed_code)
    end

    test "returns nil for playlist embed code" do
      refute SoundCloud.parse_track(@playlist_embed_code)
    end

    test "returns nil for random string" do
      refute SoundCloud.parse_track(@random_string)
    end
  end

  describe "parse_playlist/1" do
    test "returns parsed id and type for playlist embed code" do
      assert {:playlist, "605836044"} = SoundCloud.parse_playlist(@playlist_embed_code)
    end

    test "returns nil for track embed code" do
      refute SoundCloud.parse_playlist(@track_embed_code)
    end

    test "returns nil for random string" do
      refute SoundCloud.parse_playlist(@random_string)
    end
  end
end
