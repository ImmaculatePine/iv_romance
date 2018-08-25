defmodule IvRomance.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :path, :string, null: false
      add :title, :string
      add :body, :text

      timestamps()
    end

    create(unique_index(:pages, [:path]))
  end
end
