defmodule Resumex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    port = Application.get_env(:resumex, :port)

    children =
      [
        {Plug.Cowboy, scheme: :http, plug: Resumex.Router, options: [port: port]}
      ] ++ list_children_from_env(args[:env])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Resumex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp list_children_from_env(:test), do: []
  defp list_children_from_env(_), do: [{Resumex.Counter, []}]
end
