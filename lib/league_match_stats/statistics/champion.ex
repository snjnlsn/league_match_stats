defmodule LeagueMatchStats.Statistics.Champion do
  use Ecto.Schema

  @derive {Jason.Encoder, only: [:name, :image_uri, :external_id]}
  schema "champions" do
    field :name, :string
    field :image_uri, :string
    field :external_id, :string

    timestamps(type: :utc_datetime)
  end
end
