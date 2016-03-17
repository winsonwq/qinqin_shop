defmodule Calculator do

  def calculate({ :buy_two_get_one_free }, %Item{ unit_price: unit_price }, quantity) do
    pricing_item_count = div(quantity, 2) + rem(quantity, 2)
    unit_price * pricing_item_count
  end

  def calculate({ :percent_discount, percent }, %Item{ unit_price: unit_price }, quantity) when percent < 1 do
    unit_price * quantity * percent
  end

  def calculate(%Item{ unit_price: unit_price }, quantity) do
    unit_price * quantity
  end

end
