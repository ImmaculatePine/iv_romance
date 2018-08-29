defmodule IvRomanceWeb.Admin.SessionControllerTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory
  import IvRomanceWeb.LogInHelper

  describe "new session" do
    test "renders form", %{conn: conn} do
      response =
        conn
        |> get(admin_session_path(conn, :new))
        |> html_response(200)

      assert response =~ "Login"
    end
  end

  describe "create session" do
    test "redirects to root admin page on successful login", %{conn: conn} do
      %{email: email} =
        :user
        |> build()
        |> set_password("secret")
        |> insert()

      params = %{email: email, password: "secret"}

      assert admin_root_path(conn, :index) ==
               conn
               |> post(admin_session_path(conn, :create), session: params)
               |> redirected_to()
    end

    test "renders form on failed login", %{conn: conn} do
      %{email: email} = params_for(:user)

      params = %{
        email: email,
        password: "secret"
      }

      assert response =
               conn
               |> post(admin_session_path(conn, :create), session: params)
               |> html_response(200)

      assert response =~ "Login"
    end
  end

  describe "delete session" do
    test "deletes session data", %{conn: conn} do
      %{conn: conn, user: %{id: user_id}} = log_in(conn)

      refute conn
             |> delete(admin_session_path(conn, :delete, user_id))
             |> get(admin_root_path(conn, :index))
             |> get_session(:user_id)
    end
  end
end
