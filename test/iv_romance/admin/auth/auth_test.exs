defmodule IvRomance.Admin.AuthTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Admin.Auth
  alias IvRomance.Admin.Auth.User
  alias Ecto.Changeset

  describe "get_user/1" do
    test "returns a user by id" do
      %{id: id} = user = insert(:user)
      assert Auth.get_user(id) == user
    end
  end

  describe "get_user_by_email_and_password/2" do
    test "returns user when valid credentials are passed" do
      %{id: id, email: email} =
        :user
        |> build()
        |> set_password("secret")
        |> insert()

      assert {:ok, user} = Auth.get_user_by_email_and_password(email, "secret")
      assert %User{id: ^id, email: ^email} = user
    end

    test "returns unauthorized error when password is invalid" do
      %{email: email} = insert(:user)
      assert {:error, :unauthorized} = Auth.get_user_by_email_and_password(email, "secret")
    end

    test "returns not_found error when user does not exist" do
      %{email: email} = params_for(:user)
      assert {:error, :not_found} = Auth.get_user_by_email_and_password(email, "secret")
    end
  end

  describe "create_user/1" do
    test "creates a user with valid params" do
      %{email: email} = params_for(:user)
      assert {:ok, user} = Auth.create_user(%{email: email, password: "secret"})
      assert %User{id: _, email: email} = user
    end

    test "returns error changeset when email is blank" do
      assert {:error, %Changeset{} = changeset} = Auth.create_user(%{password: "secret"})
      assert %{errors: [email: {"can't be blank", [validation: :required]}]} = changeset
    end

    test "returns error changeset when password is blank" do
      %{email: email} = params_for(:user)
      assert {:error, %Changeset{} = changeset} = Auth.create_user(%{email: email})
      assert %{errors: [password: {"can't be blank", [validation: :required]}]} = changeset
    end
  end

  describe "delete_user/1" do
    test "deletes the user" do
      %{id: id} = user = insert(:user)
      assert {:ok, %User{}} = Auth.delete_user(user)
      refute Auth.get_user(id)
    end
  end
end
