defmodule IvRomance.Content.Page do
  use Ecto.Schema
  import Ecto.Changeset

  @url_regex ~r/^\/[a-z0-9\-\/]*$/
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "pages" do
    field(:body, :string)
    field(:path, :string)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:path, :title, :body])
    |> validate_required([:path, :title, :body])
    |> validate_format(:path, @url_regex)
    |> unique_constraint(:path)
  end
end
