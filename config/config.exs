# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :iv_romance,
  ecto_repos: [IvRomance.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :iv_romance, IvRomanceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0MVEZ1M8y00DNwg0Px3eQOxIS9aEesxzlwTFN040uuXlhIBSreUHkxkv0cOwmMLj",
  render_errors: [view: IvRomanceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IvRomance.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
