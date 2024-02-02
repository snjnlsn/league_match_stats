defmodule LeagueMatchStats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeagueMatchStatsWeb.Telemetry,
      LeagueMatchStats.Repo,
      {DNSCluster, query: Application.get_env(:league_match_stats, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LeagueMatchStats.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LeagueMatchStats.Finch},
      # Start a worker by calling: LeagueMatchStats.Worker.start_link(arg)
      # {LeagueMatchStats.Worker, arg},
      # Start to serve requests, typically the last entry
      LeagueMatchStatsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeagueMatchStats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeagueMatchStatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
