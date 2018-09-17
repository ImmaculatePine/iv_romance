defmodule IvRomanceWeb.Plugs.AcceptHeader do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts), do: assign(conn, :accept, get_req_header(conn, "accept"))
end
