defmodule IvRomance.Admin.Auth.Plug do
  import Plug.Conn
  import Phoenix.Controller

  alias IvRomance.Admin.Auth
  alias IvRomance.Admin.Auth.User
  alias IvRomanceWeb.Router.Helpers, as: RouterHelpers

  def init(opts), do: opts

  def call(%{assigns: %{current_user: %User{}}} = conn, _opts), do: conn

  def call(conn, _opts) do
    conn
    |> get_session(:user_id)
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
end
