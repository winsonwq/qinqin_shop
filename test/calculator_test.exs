defmodule CalculatorTest do
  use ExUnit.Case

  test "calculate item price with quantity" do
    assert Calculator.calculate(%Item{ unit_price: 10 }, 2) == 20
  end

  test "calculate item total price when match bought two for one more free" do
    item = %Item{ unit_price: 10 }
    assert Calculator.calculate(item, 3) == 20
  end

end
