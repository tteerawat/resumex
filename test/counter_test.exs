defmodule Resumex.CounterTest do
  use ExUnit.Case

  setup do
    start_supervised!(Resumex.Counter)

    :ok
  end

  describe "count/0" do
    test "returns count result correctly" do
      assert Resumex.Counter.count() == 1
      assert Resumex.Counter.count() == 2
      assert Resumex.Counter.count() == 3
    end
  end
end
