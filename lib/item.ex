defmodule Item do

  @type t :: %__MODULE__{
    name: String.t,
    unit_price: Float.t,
    unit: String.t,
    type: String.t,
    bar_code: String.t
  }

  defstruct [:name, :unit_price, :unit, :type, :bar_code]

end
