# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :genialais,
  ecto_repos: [Genialais.Repo]

# Configures the endpoint
config :genialais, GenialaisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EWkkvv4ekH53liS13LwL2HJ0qOzXlO0NQPDsa9wnd+hc6Vf1ARTousLzOdOVUWfP",
  render_errors: [view: GenialaisWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Genialais.PubSub,
  live_view: [signing_salt: "Iai4eUYR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Authentication
config :genialais, :pow,
  user: Genialais.Users.User,
  repo: Genialais.Repo,
  web_module: GenialaisWeb,
  extensions: [PowInvitation, PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: GenialaisWeb.Pow.Mailer

# Configure mailer
config :genialais, GenialaisWeb.Pow.Mailer,
  adapter: Bamboo.LocalAdapter
  #api_key: "my_api_key" # Specify adapter-specific configuration

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
