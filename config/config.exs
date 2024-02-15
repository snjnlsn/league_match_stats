# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :league_match_stats,
  ecto_repos: [LeagueMatchStats.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :league_match_stats, LeagueMatchStatsWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: LeagueMatchStatsWeb.ErrorHTML, json: LeagueMatchStatsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LeagueMatchStats.PubSub,
  live_view: [signing_salt: "BgCHOsc8"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :league_match_stats, LeagueMatchStats.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
