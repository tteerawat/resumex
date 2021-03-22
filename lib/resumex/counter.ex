defmodule Resumex.Counter do
  use GenServer

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, 0}
  end

  @spec count() :: non_neg_integer()
  def count do
    GenServer.call(__MODULE__, :count)
  end

  @impl true
  def handle_call(:count, _from, state) do
    new_state = state + 1
    {:reply, new_state, new_state}
  end
end
