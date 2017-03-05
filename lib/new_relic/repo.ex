defmodule NewRelic.Repo do
  @moduledoc """
  Records metrics directly from Ecto Logger.
  """

  def record_metrics(%Ecto.LogEntry{query: query, query_time: time}) do
    IO.inspect "Received query"
    NewRelic.Collector.record_value({:db_query, query}, time)
  end
end
