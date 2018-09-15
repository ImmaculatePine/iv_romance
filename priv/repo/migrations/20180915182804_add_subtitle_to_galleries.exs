defmodule IvRomance.Repo.Migrations.AddSubtitleToGalleries do
  use Ecto.Migration

  def change do
    alter table(:galleries) do
      add(:subtitle, :string)
    end
  end
end
