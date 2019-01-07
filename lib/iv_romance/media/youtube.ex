defmodule IvRomance.Media.Youtube do
  @url_regexp ~r/.+youtube.+\?v=(.+)/

  def parse(url) do
    with [_, descriptor] <- Regex.run(@url_regexp, url) do
      {:video, descriptor}
    else
      _ -> nil
    end
  end
end
