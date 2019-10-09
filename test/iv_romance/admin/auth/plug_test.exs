defmodule IvRomance.Admin.Auth.PlugTest do
  use IvRomanceWeb.ConnCase

  import IvRomance.Factory
  import IvRomanceWeb.LogInHelper

  alias Ecto.UUID
  alias IvRomance.Admin.Auth
  alias IvRomance.Admin.Auth.Plug, as: AuthPlug
  alias IvRomance.Admin.Auth.Token

  describe "call/2, source: :session" do
    test "does nothing when user is already assigned", %{conn: conn} do
      conn_with_user = assign(conn, :current_user, insert(:user))
      assert conn_with_user == AuthPlug.call(conn_with_user, source: :session)
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
             } = AuthPlug.call(conn, source: :session)
    end

    test "assigns nil if there is no real user id in session", %{conn: conn} do
      %{conn: conn, user: user} = log_in(conn)
      Auth.delete_user(user)

      assert %{
               assigns: %{
                 current_user: nil
               }
             } = AuthPlug.call(conn, source: :session)
    end
  end

  describe "call/2, source: :auth_header" do
    test "does nothing when user is already assigned", %{conn: conn} do
      conn_with_user = assign(conn, :current_user, insert(:user))

      assert conn_with_user == AuthPlug.call(conn_with_user, source: :auth_header)
    end

    test "assigns user if there is real user token in auth header", %{conn: conn} do
      %{id: user_id, email: email} = insert(:user)
      token = Token.sign(user_id)

      assert %{
               assigns: %{
                 current_user: %{
                   id: ^user_id,
                   email: ^email
                 }
               }
             } =
               conn
               |> put_req_header("authorization", "Bearer #{token}")
               |> AuthPlug.call(source: :auth_header)
    end

    test "assigns nil if there is no real user token in session", %{conn: conn} do
      token = Token.sign(UUID.generate())

      assert %{
               assigns: %{
                 current_user: nil
               }
             } =
               conn
               |> put_req_header("authorization", "Bearer #{token}")
               |> AuthPlug.call(source: :auth_header)
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
