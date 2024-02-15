defmodule LeagueMatchStatsWeb.SummonerController do
  use LeagueMatchStatsWeb, :controller
  alias LeagueMatchStats.Statistics

  def get(conn, %{"name" => name}) do
    {:ok, match_info} =
      Statistics.get_matches_for_summoner(name)

    json(conn, match_info)
  end
end
