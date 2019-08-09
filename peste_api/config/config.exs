# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :peste_api, PesteApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "THgwDDaali6YVmmDwI+m9WDwWqQub2TWTiu2u+XODkIuFT+CiE5yespjZBmDGo/A",
  render_errors: [view: PesteApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PesteApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
