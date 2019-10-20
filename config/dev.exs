use Mix.Config

# Configure your database
config :itemsApi, ItemsApi.Repo,
  adapter: Mongo.Ecto,
  username: "testDB",
  password: "p@$$w0rd",
  database: "admin",
  hostname: "localhost:27017",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10


config :itemsApi, ItemsApiWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []


config :itemsApi, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ItemsApiWeb.Router     # phoenix routes will be converted to swagger paths
    ]
  }


config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
