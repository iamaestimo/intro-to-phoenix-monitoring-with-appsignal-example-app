defmodule CounterLiveApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CounterLiveAppWeb.Telemetry,
      CounterLiveApp.Repo,
      {DNSCluster, query: Application.get_env(:counter_live_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CounterLiveApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CounterLiveApp.Finch},
      # Start a worker by calling: CounterLiveApp.Worker.start_link(arg)
      # {CounterLiveApp.Worker, arg},
      # Start to serve requests, typically the last entry
      CounterLiveAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CounterLiveApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CounterLiveAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
