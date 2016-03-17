defmodule StrategyTest do
  use ExUnit.Case

  @strategies [
    %{ priority: 0, items: ["ITEM00001"], mark: { :buy_x_get_y_free, 2, 1 } },
    %{ priority: 1, items: ["ITEM00001", "ITEM00002"], mark: { :percent_discount, 0.95 } }
  ]

  test "find matched strategy of ITEM00002" do
    assert [%{ mark: { :percent_discount, 0.95 } }] = Strategy.find_all_matched(@strategies, "ITEM00002")
  end

  test "find matched strategy of ITEM00001" do
    assert [
      %{ mark: { :buy_x_get_y_free, 2, 1 } },
      %{ mark: { :percent_discount, 0.95 } }
    ] = Strategy.find_all_matched(@strategies, "ITEM00001")
  end

end
