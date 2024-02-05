defmodule LeagueMatchStatsWeb.MatchController do
  use LeagueMatchStatsWeb, :controller

  def get(conn, _params) do
    render(conn, :test)
  end

  def index(conn, _params) do
    render(conn, :test)
  end
end
