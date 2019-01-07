defmodule IvRomance.Media.YoutubeTest do
  use IvRomance.DataCase, async: true

  alias IvRomance.Media.Youtube

  @video_url "https://www.youtube.com/watch?v=GpSuIF_8_r8"
  @random_string "random"

  describe "parse/1" do
    test "returns id for video URL" do
      assert {:video, "GpSuIF_8_r8"} = Youtube.parse(@video_url)
    end

    test "returns nil for random string" do
      refute Youtube.parse(@random_string)
    end
  end
end
