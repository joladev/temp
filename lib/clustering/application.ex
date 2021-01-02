defmodule Clustering.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    topologies = [
      example: [
        strategy: Cluster.Strategy.Gossip,
      ]
    ]

    children = [
      # Starts a worker by calling: Clustering.Worker.start_link(arg)
      # {Clustering.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: Clustering.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Clustering.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
