# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Used to build urls while behind a proxy like nginx. Example:
#     export ROOT_URL=https://gaga.labvoid.com
#     export PORT=4000 # => the internal port of the phoenix server
# Defaults to localhost:4000, when running without a proxy.
%{host: host, port: port, scheme: scheme} =
  URI.parse(System.get_env("ROOT_URL") || "http://localhost:4000")

config :gaga, GagaWeb.Endpoint,
  url: [host: host, port: port, scheme: scheme],
  http: [
    port: String.to_integer(System.get_env("PORT") || Integer.to_string(port)),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:

config :gaga, GagaWeb.Endpoint, server: true

# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
