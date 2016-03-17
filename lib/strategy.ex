defmodule Strategy do

  @strategies Application.get_env(:qinqin_shop, :strategies) |> Map.values

  def find_all_matched(bar_code) do
    @strategies
      |> Enum.filter(&(Enum.member?(&1.items, bar_code)))
      |> Enum.sort_by(&(&1.priority))
  end

end
