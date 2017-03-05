defmodule NewRelic.RepoTest do
  use ExUnit.Case, async: false

  import TestHelpers.Assertions

  alias NewRelic.Repo

  @query "SELECT u0.\"id\" FROM \"user\" AS u0 []"

  setup_all do
    log_entry =
      %Ecto.LogEntry{
        query: @query,
        source: "user",
        params: [],
        query_time: 1_000,
        decode_time: 89,
        queue_time: nil,
        connection_pid: self(),
        ansi_color: nil
      }
    {:ok, log_entry: log_entry}
  end

  test "record_metrics records query time", %{log_entry: log_entry} do
    Repo.record_metrics(log_entry)
    
    [time] = get_metric_by_key({:db_query, @query})

    assert time == 1_000
  end

end
