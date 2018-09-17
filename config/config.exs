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

# Configure the endpoint
config :iv_romance, IvRomanceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0MVEZ1M8y00DNwg0Px3eQOxIS9aEesxzlwTFN040uuXlhIBSreUHkxkv0cOwmMLj",
  render_errors: [view: IvRomanceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IvRomance.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure auth token
config :iv_romance, IvRomance.Admin.Auth.Token,
  secret: "60k0SK/TimOwnuLW2vZ9ihrkVjtOeDCEQ1WAFk+soS41B/tf04oTYm4e3+PV4LZV",
  salt: "3Q2oQsIYY31y2Pd7DGICPg8sGHjKL3C/qkfZ1gVsMy9018+D3GmwWG6csPq6my6I"

# Configure default locale
config :iv_romance, IvRomanceWeb.Gettext, default_locale: "ru"

# Configure your database
config :iv_romance, IvRomance.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

# Configure uploader
config :iv_romance, IvRomance.Uploads.S3,
  bucket: System.get_env("UPLOADS_S3_BUCKET"),
  adapter: IvRomance.Uploads.S3.Adapter.Aws

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configure AWS
config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: "eu-central-1"

# Configure Arc uploader
config :arc,
  storage: Arc.Storage.S3,
  virtual_host: true,
  bucket: System.get_env("UPLOADS_S3_BUCKET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
