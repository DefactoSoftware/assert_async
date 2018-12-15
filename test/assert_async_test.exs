defmodule AssertAsyncTest do
  use ExUnit.Case

  import AssertAsync

  test("can't find it with a direct assert") do
    {:ok, pid} = GenServer.start_link(AsyncTestServer, [])

    Task.async(fn ->
      GenServer.cast(pid, {:update, :some_state})
    end)

    refute :some_state == GenServer.call(pid, :return)
  end

  test "can find it with assert_eventually" do
    {:ok, pid} = GenServer.start_link(AsyncTestServer, [])

    Task.async(fn ->
      GenServer.cast(pid, {:update, :some_state})
    end)

    assert_eventually(:some_state == GenServer.call(pid, :return))
  end
end
