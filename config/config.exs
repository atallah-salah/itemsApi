
use Mix.Config

config :itemsApi,
  ecto_repos: [ItemsApi.Repo]

# Configures the endpoint
config :itemsApi, ItemsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/WmzxXH9dja59GkxnDdgWyl4cXTFFNw2SxBFmjY2ntSV1kfsarSjehCKQ+jHk32w",
  render_errors: [view: ItemsApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ItemsApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :itemsApi, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ItemsApiWeb.Router     # phoenix routes will be converted to swagger paths
    ]
  }

import_config "#{Mix.env()}.exs"
