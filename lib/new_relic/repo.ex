defmodule NewRelic.Repo do
  @moduledoc """
  Records metrics directly from Ecto Logger.
  """

  def record_metrics(%Ecto.LogEntry{query: query, query_time: time}) do
    NewRelic.Collector.record_value({:db, query}, time)
  end
end
