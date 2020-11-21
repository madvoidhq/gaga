# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :gaga, GagaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cVTPf6Fk2McmjwNyVD16FXqE2or8078pk3zmhKCBQIADHP/uzSmC68+g2XimPAs7",
  encryption_salt: "G43rOH1s",
  signing_salt: "K6DnElJu",
  render_errors: [view: GagaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gaga.PubSub,
  live_view: [signing_salt: "hmmA8j8U"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
