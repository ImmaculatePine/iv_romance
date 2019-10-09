defmodule IvRomance.Media.Youtube do
  @url_regexp ~r/.+youtube.+\?v=(.+)/

  def parse(url) do
    case Regex.run(@url_regexp, url) do
      [_, descriptor] -> {:video, descriptor}
      _ -> nil
    end
  end
end
