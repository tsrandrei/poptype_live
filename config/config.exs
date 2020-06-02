# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :poptype_live,
  ecto_repos: [PoptypeLive.Repo]

# Configures the endpoint
config :poptype_live, PoptypeLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GqT2nfF/xKK/sKIo0Ayot3QDVsqjDGpp9QTjBZ7h6qlLXM7ku6dQdEGie0Lkck24",
  render_errors: [view: PoptypeLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PoptypeLive.PubSub,
  live_view: [signing_salt: "Cu5VFdQK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
