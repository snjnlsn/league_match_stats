defmodule LeagueMatchStatsWeb.SummonerController do
  use LeagueMatchStatsWeb, :controller

  def get(conn, _params) do
    render(conn, :test)
  end
end
