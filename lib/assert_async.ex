defmodule AssertAsync do
  @moduledoc """
  Assert results with retries
  """
  require Logger

  @doc """
  This does the same as assert, but when it fails it retries up to 5 times and
  waiting for 100 ms. To wait for the javascript to finish
  """
  defmacro assert_eventually(assertion, opts \\ []) do
    quote do
      assert AssertAsync.retry(
               fn -> !!unquote(assertion) end,
               unquote(opts)
             )
    end
  end

  def retry(func, opts \\ [])
  def retry(func, %{retries: 1}), do: func.()

  def retry(func, %{step: step, evaluator: evaluator} = opts) do
    value = safe_call(func)

    case evaluator.(value) do
      true ->
        value

      false ->
        wait_and_recurse(func, opts)

      %RuntimeError{message: message} ->
        Logger.info("""
          Error on #{step_to_ordinal(step)} try with following message:
          #{message}
          STACKTRACE:
          #{Exception.format_stacktrace()}
        """)

        wait_and_recurse(func, opts)
    end
  end

  def retry(func, opts) do
    # just add default values
    retry(
      func,
      Enum.into(opts, %{
        retries: 8,
        step_time: 100,
        step: 1,
        evaluator: & &1
      })
    )
  end

  defp wait_and_recurse(func, %{
         retries: retries,
         step_time: step_time,
         step: step,
         evaluator: evaluator
       }) do
    wait_for(step_time) &&
      retry(func, %{
        retries: retries - 1,
        step_time: step_time * step,
        step: step + 1,
        evaluator: evaluator
      })
  end

  defp safe_call(func) do
    func.()
  rescue
    e in RuntimeError -> e
  end

  defp wait_for(milliseconds) do
    case :timer.sleep(milliseconds) do
      :ok ->
        true

      # this should never happen
      _ ->
        false
    end
  end

  defp step_to_ordinal(1), do: "1st"
  defp step_to_ordinal(2), do: "2nd"
  defp step_to_ordinal(3), do: "3rd"
  defp step_to_ordinal(n), do: "#{n}th"
end
