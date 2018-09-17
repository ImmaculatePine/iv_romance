defmodule IvRomance.Repo.Migrations.AddPositionToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add(:position, :integer)
    end
  end
end
