defmodule LeagueMatchStats.Statistics do
  alias LeagueMatchStats.Statistics.{Match, Client}

  def get_matches_for_summoner(name) do
    with {:ok, puuid} <- Client.fetch_summoner(name),
         {:ok, match_ids} <- Client.fetch_match_ids(puuid),
         {initial_ids, remaining_ids} <- Enum.split(match_ids, 15),
         matches <-
           hydrate_matches(initial_ids, puuid) do
      {:ok, %{matches: matches, remaining_match_ids: remaining_ids, puuid: puuid}}
    else
      _error ->
        {:error, "error fetching matches"}
    end
  end

  def get_details_for_matches(matches, puuid) do
    with {initial_ids, remaining_ids} <- Enum.split(matches, 15),
         matches <-
           hydrate_matches(initial_ids, puuid) do
      {:ok, %{matches: matches, remaining_match_ids: remaining_ids}}
    else
      _error ->
        {:error, "error fetching matches"}
    end
  end

  defp hydrate_matches(match_ids, puuid) do
    match_ids
    |> Enum.map(fn id ->
      with {:ok, response} <- Client.fetch_match(id),
           {:ok, match} <- Match.process_match_response(response, puuid) do
        match
      else
        e -> e
      end
    end)
    |> Enum.filter(&is_match/1)
  end

  defp is_match(%Match{}), do: true
  defp is_match(_), do: false
end
