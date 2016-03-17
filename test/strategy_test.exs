defmodule StrategyTest do
  use ExUnit.Case

  test "find matched strategy of ITEM00002" do
    assert [%{ mark: { :percent_discount, 0.95 } }] = Strategy.find_all_matched("ITEM00002")
  end

  test "find matched strategy of ITEM00001" do
    assert [
      %{ mark: { :buy_two_get_one_free } },
      %{ mark: { :percent_discount, 0.95 } }
    ] = Strategy.find_all_matched("ITEM00001")
  end

end
