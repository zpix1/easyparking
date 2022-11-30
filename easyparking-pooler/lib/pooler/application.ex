defmodule Pooler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Pooler.Clients.ParkingImages

  @impl true
  def start(_type, _args) do
    Pooler.Mnesia.setup([node()])

    children = [
      ParkingImages.child_spec(),
      {Task.Supervisor, name: Pooler.TaskSupervisor},
      Pooler.Scheduler,
      # Start the Telemetry supervisor
      PoolerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pooler.PubSub},
      # Start the Endpoint (http/https)
      PoolerWeb.Endpoint
      # Start a worker by calling: Pooler.Worker.start_link(arg)
      # {Pooler.Worker, arg}
    ]

    children =
      if Pooler.env() != :test do
        [Pooler.Broadway | children]
      else
        children
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pooler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PoolerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
