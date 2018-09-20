defmodule IvRomance.Factory do
  use ExMachina.Ecto, repo: IvRomance.Repo

  alias IvRomance.Content.Page
  alias IvRomance.Photo.{Gallery, Image}
  alias IvRomance.Admin.Auth.User
  alias IvRomance.Media.Object, as: MediaObject

  def page_factory do
    %Page{
      path: sequence(:path, &"/page/#{&1}"),
      title: sequence(:title, &"Page #{&1}"),
      body: sequence(:page, &"Page #{&1} body")
    }
  end

  def gallery_factory do
    %Gallery{
      title: sequence(:title, &"Gallery #{&1}"),
      subtitle: sequence(:subtitle, &"Subtitle #{&1}")
    }
  end

  def image_factory do
    %Image{
      gallery: build(:gallery),
      filename: sequence(:filename, &"image-#{&1}.png"),
      position: sequence(:position, & &1)
    }
  end

  def media_object_factory do
    descriptor = sequence(:descriptor, &"media-object-#{&1}")

    embed_code =
      ~s(<iframe src="https://api.soundcloud.com/tracks/#{descriptor}&color=%23ff5500"></iframe>)

    %MediaObject{
      provider: "sound_cloud",
      type: "track",
      descriptor: descriptor,
      embed_code: embed_code,
      title: sequence(:title, &"Media object #{&1}")
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
