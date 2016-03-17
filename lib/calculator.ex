defmodule Calculator do

  alias Decimal, as: D

  def calculate({ :buy_x_get_y_free, x, y }, %Item{ unit_price: unit_price }, quantity) do
    1..quantity
      |> Enum.filter(fn idx -> rem(idx - 1, x + y) < x end)
      |> Enum.map(fn _ -> D.new(unit_price) end)
      |> Enum.reduce(&D.add(&1, &2))
  end

  def calculate({ :percent_discount, percent }, %Item{ unit_price: unit_price }, quantity) when percent < 1 do
    unit_price
      |> D.new
      |> D.mult(D.new(quantity))
      |> D.mult(D.new(percent))
  end

  def calculate({ nil }, %Item{ unit_price: unit_price }, quantity) do
    D.new(unit_price) |> D.mult(D.new(quantity))
  end

end
