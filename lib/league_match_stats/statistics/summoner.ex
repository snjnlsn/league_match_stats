defmodule LeagueMatchStats.Statistics.Summoner do
  use Ecto.Schema

  @derive Jason.Encoder
  embedded_schema do
    field :puuid, :string
    field :name, :string
    field :icon_uri, :string
    field :level, :string
    field :summoner_id, :string
  end
end
