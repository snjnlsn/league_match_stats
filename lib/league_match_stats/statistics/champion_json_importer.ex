defmodule LeagueMatchStats.Statistics.ChampionJSONImporter do
  @moduledoc """
    Parse relevant Champion data from Data Dragon JSON and store in DB because API does
    not provide this info easily from what I can tell. ¯\_(ツ)_/¯
  """
  alias LeagueMatchStats.Statistics.Champion
  alias LeagueMatchStats.Repo

  @doc """
  Currently, I just run this manually in IEx. In a production context, I would opt to add de-duping logic and convert this to an Oban job.
  """
  def run() do
    with {:ok, raw} <- File.read("./champions.json"),
         {:ok, %{"data" => data}} <- Jason.decode(raw),
         {:ok, entries} <-
           map_to_entries(data),
         {:ok, _response} <-
           Repo.insert_all(Champion, entries) do
      :ok
    else
      error ->
        error
    end
  end

  @doc """
  Data map is keyed by champion name, so we grab all the keys (champion names) from the map, and
  reduce using that list to populate a map of attributes to persist each Champion's info into the database.
  """
  def map_to_entries(data) do
    entries =
      data
      |> Map.keys()
      |> Enum.reduce([], fn key, acc ->
        [
          %{
            name: get_in(data, [key, "name"]),
            external_id: get_in(data, [key, "key"]),
            image_uri: get_in(data, [key, "image", "full"]),
            inserted_at: DateTime.now!("Etc/UTC") |> DateTime.truncate(:second),
            updated_at: DateTime.now!("Etc/UTC") |> DateTime.truncate(:second)
          }
          | acc
        ]
      end)

    {:ok, entries}
  end
end
