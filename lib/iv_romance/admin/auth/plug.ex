defmodule IvRomance.Admin.Auth.Plug do
  import Plug.Conn
  import Phoenix.Controller

  alias IvRomance.Admin.Auth
  alias IvRomance.Admin.Auth.{User, Token}
  alias IvRomanceWeb.Router.Helpers, as: RouterHelpers

  @regexp_token Regex.compile!("^Bearer (.*)$")

  def init(source: source), do: [source: source]
  def init(_), do: [source: :session]

  def call(%{assigns: %{current_user: %User{}}} = conn, _opts), do: conn

  def call(conn, source: :session) do
    conn
    |> read_token_from_session()
    |> find_user()
    |> assign_current_user(conn)
  end

  def call(conn, source: :auth_header) do
    conn
    |> read_token_from_header()
    |> find_user()
    |> assign_current_user(conn)
  end

  def authenticate_user(%{assigns: %{current_user: %User{}}} = conn, _opts), do: conn

  def authenticate_user(conn, _opts) do
    conn
    |> put_flash(:error, "You must be logged in to access this page")
    |> redirect(to: RouterHelpers.admin_session_path(conn, :new))
    |> halt()
  end

  defp find_user(nil), do: nil
  defp find_user(user_id), do: Auth.get_user(user_id)

  defp assign_current_user(user, conn), do: assign(conn, :current_user, user)

  defp read_token_from_session(conn), do: get_session(conn, :user_id)

  defp read_token_from_header(conn) do
    conn
    |> get_req_header("authorization")
    |> Enum.at(0, "")
    |> run_regex()
    |> extract_token()
    |> decode_token()
  end

  defp run_regex(token), do: Regex.run(@regexp_token, token)

  defp extract_token([_, token]), do: token
  defp extract_token(nil), do: nil

  def decode_token(nil), do: nil

  def decode_token(token) do
    with {:ok, user_id} <- Token.verify(token) do
      user_id
    else
      _ -> nil
    end
  end
end
