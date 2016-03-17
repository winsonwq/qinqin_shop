defmodule QinqinShopTest do
  use ExUnit.Case
  alias Decimal, as: D

  @items [
    %Item{ bar_code: "ITEM00001", name: "可口可乐", unit_price: 3, unit: "瓶" },
    %Item{ bar_code: "ITEM00002", name: "羽毛球", unit_price: 1, unit: "个" },
    %Item{ bar_code: "ITEM00003", name: "苹果", unit_price: 5.5, unit: "斤" },
    %Item{ bar_code: "ITEM00004", name: "鼠标", unit_price: 25, unit: "个" }
  ]

  @strategies [
    %{ priority: 0, items: ["ITEM00001"], mark: { :buy_x_get_y_free, 2, 1 } },
    %{ priority: 1, items: ["ITEM00001", "ITEM00002"], mark: { :percent_discount, 0.95 } },
    %{ priority: 2, items: ["ITEM00004"], mark: { :percent_discount, 0.5 } }
  ]

  test "find item with matched strategy for ITEM00001" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    assert %{ mark: { :buy_x_get_y_free, 2, 1 }, item: @items |> List.first } == QinqinShop.find_item_with_strategy_mark("ITEM00001", shop)
  end

  test "find item with matched strategy for ITEM00002" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    assert %{ mark: { :percent_discount, 0.95 }, item: @items |> Enum.at(1) } == QinqinShop.find_item_with_strategy_mark("ITEM00002", shop)
  end

  test "find item with matched strategy for ITEM00003" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    assert %{ mark: { nil }, item: @items |> Enum.at(2) } == QinqinShop.find_item_with_strategy_mark("ITEM00003", shop)
  end

  test "calculate shopping item ITEM00001 with quantity 3 and related strategy" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    %{ total_price: total_price, saving_price: saving_price, mark: mark } = QinqinShop.calculate_item_price("ITEM00001", 3, shop)

    assert total_price |> D.equal?(D.new(6))
    assert saving_price |> D.equal?(D.new(3))
    assert { :buy_x_get_y_free, 2, 1 } == mark

  end

  test "calculate shopping item ITEM00002 with quantity 3 and related strategy" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    %{ total_price: total_price, saving_price: saving_price, mark: mark } = QinqinShop.calculate_item_price("ITEM00002", 3, shop)

    assert total_price |> D.equal?(D.new(2.85))
    assert saving_price |> D.equal?(D.new(0.15))
    assert { :percent_discount, 0.95 } == mark

  end

  test "calculate shopping item ITEM00004 with quantity 2 and related strategy" do
    shop = %QinqinShop{ strategies: @strategies, items: @items }
    %{ total_price: total_price, saving_price: saving_price, mark: mark } = QinqinShop.calculate_item_price("ITEM00004", 2, shop)

    assert total_price |> D.equal?(D.new(25))
    assert saving_price |> D.equal?(D.new(25))
    assert { :percent_discount, 0.5 } == mark

  end

end
