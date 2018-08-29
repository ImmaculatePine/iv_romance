defmodule IvRomanceWeb.Admin.SessionController do
  use IvRomanceWeb, :controller

  alias IvRomance.Admin.Auth

  def new(conn, _params), do: render(conn, "new.html")

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Auth.get_user_by_email_and_password(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: admin_root_path(conn, :index))

      {:error, _reason} ->
        render(conn, "new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: admin_root_path(conn, :index))
  end
end
