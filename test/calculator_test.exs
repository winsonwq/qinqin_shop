defmodule CalculatorTest do
  use ExUnit.Case

  alias Decimal, as: D

  test "calculate item price with quantity" do
    item = %Item{ unit_price: 10.5 }
    assert Calculator.calculate({ nil }, item, 2) |> D.equal?(D.new(21))
  end

  test "calculate item total price when match bought two for one more free" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :buy_x_get_y_free, 2, 1 }, item, 3) |> D.equal?(D.new(20))
  end


  test "calculate item total price when quantity not match buy x get y free" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :buy_x_get_y_free, 3, 2 }, item, 3) |> D.equal?(D.new(30))
  end

  test "calculate item total price when match bought three for two more free" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :buy_x_get_y_free, 3, 2 }, item, 4) |> D.equal?(D.new(30))
  end

  test "calculate item total price when match bought three for two more free for quantity 7" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :buy_x_get_y_free, 3, 2 }, item, 7) |> D.equal?(D.new(50))
  end

  test "calculate item total price when match 95 percent discount" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :percent_discount, 0.95 }, item, 1) |> D.equal?(D.new(9.5))
  end

  test "calculate item total price when match other percent discount" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :percent_discount, 0.55 }, item, 2) |> D.equal?(D.new(11))
  end

end
