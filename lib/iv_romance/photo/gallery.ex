defmodule IvRomance.Photo.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  alias IvRomance.Photo.Image

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "galleries" do
    field(:title, :string)

    has_many(:images, Image, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
