defmodule Gaga.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GagaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gaga.PubSub},
      # Start the Endpoint (http/https)
      GagaWeb.Endpoint,
      # Start the Presence system
      GagaWeb.Presence
      # Start a worker by calling: Gaga.Worker.start_link(arg)
      # {Gaga.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gaga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GagaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
