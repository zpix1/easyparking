# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :pooler, PoolerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PoolerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Pooler.PubSub,
  live_view: [signing_salt: "sm+bQewW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pooler, :pow, users_context: Pooler.Accounts.UsersContext

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

timezone = "Asia/Novosibirsk"

config :pooler, :timezone, timezone

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
