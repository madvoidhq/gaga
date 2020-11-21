# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

get_env_token = fn env_variable, default_token_length ->
  token_length = Enum.max([default_token_length, 32])

  example_token =
    :crypto.strong_rand_bytes(token_length)
    |> Base.encode64()
    |> binary_part(0, default_token_length)

  System.get_env(env_variable) ||
    raise """
    environment variable #{env_variable} is missing.
    You can generate one by calling: `mix phx.gen.secret #{token_length}` or use this random one:
    export #{env_variable}=#{example_token}
    """
end

secret_key_base = get_env_token.("SECRET_KEY_BASE", 64)
encryption_salt = get_env_token.("ENCRYPTION_SALT", 8)
signing_salt = get_env_token.("SIGNING_SALT", 8)
live_view_signing_salt = get_env_token.("LIVE_VIEW_SIGNING_SALT", 8)

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
  secret_key_base: secret_key_base,
  encryption_salt: encryption_salt,
  signing_salt: signing_salt,
  live_view: [signing_salt: live_view_signing_salt]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:

config :gaga, GagaWeb.Endpoint, server: true

# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
