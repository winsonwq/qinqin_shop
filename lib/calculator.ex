defmodule Calculator do

  alias Decimal, as: D

  def calculate({ :buy_two_get_one_free }, %Item{ unit_price: unit_price }, quantity) do
    pricing_item_count = div(quantity, 2)
      |> D.new
      |> D.add(D.new(rem(quantity, 2)))

    D.new(unit_price) |> D.mult(D.new(pricing_item_count))
  end

  def calculate({ :percent_discount, percent }, %Item{ unit_price: unit_price }, quantity) when percent < 1 do
    D.new(unit_price)
      |> D.mult(D.new(quantity))
      |> D.mult(D.new(percent))
  end

  def calculate({ nil }, %Item{ unit_price: unit_price }, quantity) do
    D.new(unit_price) |> D.mult(D.new(quantity))
  end

end
