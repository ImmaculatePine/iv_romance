defmodule IvRomance.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add(:filename, :string)

      add(:gallery_id, references(:galleries, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:images, [:gallery_id]))
  end
end
