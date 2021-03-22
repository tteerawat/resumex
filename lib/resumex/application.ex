defmodule Resumex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:resumex, :port)

    children = [
      # Starts a worker by calling: Resumex.Worker.start_link(arg)
      # {Resumex.Worker, arg}

      {Plug.Cowboy, scheme: :http, plug: Resumex.Router, options: [port: port]},
      {Resumex.Counter, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Resumex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
