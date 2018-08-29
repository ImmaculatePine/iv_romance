defmodule IvRomance.Admin.Auth.PlugTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory
  import IvRomanceWeb.LogInHelper

  alias IvRomance.Admin.Auth
  alias IvRomance.Admin.Auth.Plug, as: AuthPlug

  describe "call/2" do
    test "does nothing when user is already assigned", %{conn: conn} do
      conn_with_user = assign(conn, :current_user, insert(:user))
      assert conn_with_user == AuthPlug.call(conn_with_user, %{})
    end

    test "assigns user if there is real user id in session", %{conn: conn} do
      %{conn: conn, user: %{id: user_id, email: email}} = log_in(conn)

      assert %{
               assigns: %{
                 current_user: %{
                   id: ^user_id,
                   email: ^email
                 }
               }
             } = AuthPlug.call(conn, %{})
    end

    test "assigns nil if there is no real user id in session", %{conn: conn} do
      %{conn: conn, user: user} = log_in(conn)
      Auth.delete_user(user)

      assert %{
               assigns: %{
                 current_user: nil
               }
             } = AuthPlug.call(conn, %{})
    end
  end

  describe "authenticate_user/2" do
    test "does nothing when user is assigned", %{conn: conn} do
      conn_with_user = assign(conn, :current_user, insert(:user))
      assert conn_with_user == AuthPlug.authenticate_user(conn_with_user, %{})
      refute conn_with_user.halted
    end

    test "halts connection when user is not assigned", %{conn: conn} do
      halted_conn =
        conn
        |> bypass_through(IvRomanceWeb.Router, :browser)
        |> get(admin_root_path(conn, :index))
        |> AuthPlug.authenticate_user(%{})

      assert halted_conn.halted
    end
  end
end
