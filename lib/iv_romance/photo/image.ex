defmodule IvRomance.Photo.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias IvRomance.Photo.Gallery

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "images" do
    field(:filename, :string)
    field(:position, :integer)

    belongs_to(:gallery, Gallery)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:gallery_id, :filename, :position])
    |> validate_required([:gallery_id, :position])
    |> foreign_key_constraint(:gallery_id)
  end
end
