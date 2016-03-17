defmodule Calculator do

  def calculate(%Item{ unit_price: unit_price }, quantity) do
    unit_price * quantity
  end

end
