defmodule Aoc2021.Day02 do
  defmodule Position do
    defstruct [:x, :y, :aim]
  end

  def part_one(input) do
    input
    |> Enum.reduce(%Position{x: 0, y: 0}, fn elem, acc ->
      elem
      |> String.split()
      |> adjust_position(acc, :without_aim)
    end)
    |> calc_result()
  end

  def part_two(input) do
    input
    |> Enum.reduce(%Position{x: 0, y: 0}, fn elem, acc ->
      elem
      |> String.split()
      |> adjust_position(acc, :with_aim)
    end)
    |> calc_result()
  end

  defp adjust_position([word, number], acc, :without_aim) do
    case {word, String.to_integer(number)} do
      {"forward", num} -> Map.update!(acc, :x, &(&1 + num))
      {"down", num} -> Map.update!(acc, :y, &(&1 + num))
      {"up", num} -> Map.update!(acc, :y, &(&1 - num))
    end
  end

  defp adjust_position([word, number], acc, :with_aim) do
    case {word, String.to_integer(number)} do
      {"forward", num} -> Map.update!(acc, :x, &(&1 + num))
      {"down", num} -> Map.update!(acc, :y, &(&1 + num))
      {"up", num} -> Map.update!(acc, :y, &(&1 - num))
    end
  end

  defp calc_result(%Position{x: x, y: y}) do
    x * y
  end
end
