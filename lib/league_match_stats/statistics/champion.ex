defmodule LeagueMatchStats.Statistics.Champion do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :image_uri, :external_id]}
  schema "champions" do
    field :name, :string
    field :image_uri, :string
    field :external_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(champion, attrs) do
    champion
    |> cast(attrs, [:name, :image_uri, :external_id])
  end
end
