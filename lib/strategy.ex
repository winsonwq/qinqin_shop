defmodule Strategy do

  def find_all_matched(strategies, bar_code) do
    strategies
      |> Enum.filter(&(Enum.member?(&1.items, bar_code)))
      |> Enum.sort_by(&(&1.priority))
  end

  def strategies do
    strategies
  end

end
