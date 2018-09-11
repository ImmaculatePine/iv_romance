use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :iv_romance, IvRomanceWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :iv_romance, IvRomance.Repo,
  username: "postgres",
  password: "postgres",
  database: "iv_romance_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure uploader
config :iv_romance, IvRomance.Uploads.S3,
  bucket: "iv-romance-uploads-test",
  adapter: IvRomance.Uploads.S3.Adapter.Mock

# Configure Arc uploader
config :arc, storage: Arc.Storage.Local, bucket: "iv-romance-uploads-test"

# Reduce the number of encryption rounds
config :bcrypt_elixir, log_rounds: 4
