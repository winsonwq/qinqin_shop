defmodule QinqinShop do

  require Decimal

  @type t :: %__MODULE__{
    strategies: Map.t,
    items: Map.t
  }

  defstruct [:strategies, :items]

  def find_item_with_strategy_mark(bar_code, %QinqinShop{ strategies: strategies, items: items }) do
    items
      |> Enum.filter(&(&1.bar_code == bar_code))
      |> Enum.map(fn(item) ->

        %{ mark: mark } =
          Strategy.find_all_matched(strategies, item.bar_code)
            |> List.first
          || %{ mark: { nil } }

        %{ item: item, mark: mark }
      end)
      |> List.first
  end

  def calculate_item_price(bar_code, quantity, shop) do
    %{ mark: mark, item: item } = find_item_with_strategy_mark(bar_code, shop)

    total_price = Calculator.calculate(mark, item, quantity)
    saving_price = Calculator.calculate({ nil }, item, quantity) |> Decimal.sub(total_price)

    %{ total_price: total_price, saving_price: saving_price, item: item, mark: mark }

  end

end
