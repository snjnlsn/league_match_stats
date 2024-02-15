defmodule LeagueMatchStats.Repo.Migrations.CreateChampions do
  use Ecto.Migration

  def change do
    create table(:champions) do
      add :name, :string
      add :image_uri, :string
      add :external_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
