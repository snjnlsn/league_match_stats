defmodule LeagueMatchStatsWeb.MatchController do
  use LeagueMatchStatsWeb, :controller
  alias LeagueMatchStats.Statistics

  def post(conn, %{"matches" => matches, "puuid" => puuid}) do
    {:ok, match_details} = Statistics.get_details_for_matches(matches, puuid)

    json(conn, match_details)
  end
end
