defmodule IvRomanceWeb.MediaObjectController do
  use IvRomanceWeb, :controller

  alias IvRomance.Media

  def index(conn, _params) do
    media_objects = Media.list_media_objects()
    render(conn, "index.html", media_objects: media_objects)
  end
end
