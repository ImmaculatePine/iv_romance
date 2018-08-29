defmodule IvRomance.Factory do
  use ExMachina.Ecto, repo: IvRomance.Repo

  alias IvRomance.Content.Page
  alias IvRomance.Admin.Auth.User

  def page_factory do
    %Page{
      path: sequence(:path, &"/page/#{&1}"),
      title: sequence(:title, &"Page #{&1}"),
      body: sequence(:page, &"Page #{&1} body")
    }
  end

  def user_factory do
    %User{
      email: sequence(:email, &"user-#{&1}@example.com"),
      password_hash: "secret-hash"
    }
  end

  def set_password(user, password) do
    user
    |> User.create_changeset(%{"password" => password})
    |> Ecto.Changeset.apply_changes()
  end
end
