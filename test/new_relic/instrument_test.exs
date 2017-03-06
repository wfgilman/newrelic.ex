defmodule NewRelic.InstrumentTest do
  use ExUnit.Case, async: false

  import TestHelpers.Assertions

  alias NewRelic.Instrument

  test "record/1 records query time" do
    mfa = {:timer, :sleep, [500]}
    Instrument.record(mfa, :db)

    [time] = get_metric_by_key({"timer.sleep", {:db, "timer.sleep"}})

    assert_between(time, 500_000, 505_000) 
  end

end
