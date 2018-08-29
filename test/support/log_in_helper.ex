defmodule IvRomanceWeb.LogInHelper do
  use Phoenix.ConnTest

  import IvRomance.Factory
  import IvRomanceWeb.Router.Helpers

  @endpoint IvRomanceWeb.Endpoint

  def log_in(conn) do
    %{email: email} =
      user =
      :user
      |> build()
      |> set_password("secret")
      |> insert()

    params = %{email: email, password: "secret"}

    conn = post(conn, admin_session_path(conn, :create), session: params)

    %{conn: conn, user: user}
  end
end
