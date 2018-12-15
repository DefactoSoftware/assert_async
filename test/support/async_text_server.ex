defmodule AsyncTestServer do
  use GenServer

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:update, some_state}, _) do
    {:noreply, some_state}
  end

  def handle_call(:return, _, state) do
    {:reply, state, state}
  end
end
