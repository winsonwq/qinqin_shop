defmodule Strategy do

  def find_all_matched_strategy(strategies, bar_code) do
    strategies
      |> Enum.filter(&(Enum.member?(&1.items, bar_code)))
      |> Enum.sort_by(&(&1.priority))
  end

  def find_matched_strategy(strategies, bar_code, quantity) do
    strategies
      |> find_all_matched_strategy(bar_code)
      |> Enum.filter(&(match_strategy?(&1.mark, quantity)))
      |> List.first
  end

  defp match_strategy?({ :buy_x_get_y_free, x, _ }, quantity) do
    quantity > x
  end

  defp match_strategy?({ :percent_discount, _ }, _) do
    true
  end

  def strategies do
    strategies
  end

end
