defmodule IvRomance.Media.Object do
  use Ecto.Schema
  import Ecto.Changeset

  alias IvRomance.Media.Parser

  @providers ~w(sound_cloud youtube)

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "media_objects" do
    field(:provider, :string)
    field(:type, :string)
    field(:descriptor, :string)
    field(:title, :string)
    field(:embed_code, :string, virtual: true)

    timestamps()
  end

  @doc false
  def create_changeset(object, attrs) do
    object
    |> cast(attrs, ~w(embed_code title)a)
    |> cast_embed_code()
    |> validate_required(~w(provider type descriptor)a)
    |> validate_inclusion(:provider, @providers)
  end

  @doc false
  def update_changeset(object, attrs), do: cast(object, attrs, [:title])

  defp cast_embed_code(changeset) do
    changeset
    |> get_change(:embed_code)
    |> maybe_parse_embed_code(changeset)
  end

  defp maybe_parse_embed_code(nil, changeset), do: changeset

  defp maybe_parse_embed_code(embed_code, changeset) do
    case Parser.to_attrs(embed_code) do
      %{} = attrs ->
        cast(changeset, attrs, ~w(provider type descriptor))

      nil ->
        changeset
    end
  end
end
