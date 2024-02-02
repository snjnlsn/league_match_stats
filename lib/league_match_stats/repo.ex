defmodule LeagueMatchStats.Repo do
  use Ecto.Repo,
    otp_app: :league_match_stats,
    adapter: Ecto.Adapters.Postgres
end
