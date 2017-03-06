defmodule NewRelic.Instrument do
  @moduledoc """
  General instrumentation functionality.
  """

  @doc """
  Records execution time of a function.
  """
  @spec record(mfa, atom) :: any
  def record({mod, fun, args}, scope) when is_atom(scope) do
    f = fn -> Kernel.apply(mod, fun, args) end
    {elapsed, result} = :timer.tc(f)
    name = "#{mod}.#{to_string(fun)}"
    :ok = NewRelic.Collector.record_value({name, {scope, name}}, elapsed)
    result
  end
end
