defmodule IvRomance.Factory do
  use ExMachina.Ecto, repo: IvRomance.Repo

  alias IvRomance.Content.Page
  alias IvRomance.Photo.{Gallery, Image}
  alias IvRomance.Admin.Auth.User

  def page_factory do
    %Page{
      path: sequence(:path, &"/page/#{&1}"),
      title: sequence(:title, &"Page #{&1}"),
      body: sequence(:page, &"Page #{&1} body")
    }
  end

  def gallery_factory do
    %Gallery{
      title: sequence(:title, &"Gallery #{&1}")
    }
  end

  def image_factory do
    %Image{
      gallery: build(:gallery),
      filename: sequence(:filename, &"image-#{&1}.png")
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
