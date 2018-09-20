defmodule IvRomance.Repo.Migrations.CreateMediaObjects do
  use Ecto.Migration

  def change do
    create table(:media_objects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :provider, :string, null: false
      add :type, :string, null: false
      add :descriptor, :string, null: false
      add :title, :string

      timestamps()
    end
  end
end
