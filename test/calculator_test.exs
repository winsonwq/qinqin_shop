defmodule CalculatorTest do
  use ExUnit.Case

  test "calculate item price with quantity" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate(item, 2) == 20.0
  end

  test "calculate item total price when match bought two for one more free" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :buy_two_get_one_free }, item, 3) == 20.0
  end

  test "calculate item total price when match 95 percent discount" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :percent_discount, 0.95 }, item, 1) == 9.5
  end

  test "calculate item total price when match other percent discount" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate({ :percent_discount, 0.55 }, item, 2) == 11
  end

end
