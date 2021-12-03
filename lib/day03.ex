defmodule Aoc2021.Day03 do
  defmodule Result do
    defstruct [:input, :gamma, :epsilon]
  end

  def part_one(input) do
    split_input = Enum.map(input, &String.split(&1, "", trim: true))

    %Result{input: split_input}
    |> calc()
    |> sum_result()
  end

  def part_two(input) do
    zipped_input = input |> Enum.map(&String.split(&1, "", trim: true)) |> Enum.zip()
    o2_rating = filter(input, zipped_input, 0, &max/1)
    co2_rating = filter(input, zipped_input, 0, &min/1)

    o2_rating * co2_rating
  end

  defp max(enum) do
    Enum.max_by(enum, fn {k, v} -> {v, k} end)
  end

  defp min(enum) do
    Enum.min_by(enum, fn {k, v} -> {v, k} end)
  end

  defp filter([input | []], _zipped, _count, _compare_func) do
    input |> String.split("", trim: true) |> decimal_from_binary_int()
  end

  defp filter(input, zipped, count, compare_func) do
    {starting_digit, _} =
      zipped
      |> List.first()
      |> Tuple.to_list()
      |> Enum.frequencies()
      |> compare_func.()

    remaining =
      input
      |> Enum.filter(fn elem -> String.at(elem, count) == starting_digit end)

    remaining_zipped =
      remaining
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.zip()
      |> Enum.drop(count + 1)

    filter(remaining, remaining_zipped, count + 1, compare_func)
  end

  defp calc(%Result{input: input} = data) do
    %{gamma: raw_gamma, epsilon: raw_epsilon} =
      input
      |> Enum.zip_reduce(%{gamma: [], epsilon: []}, fn elem, acc ->
        {{min, _}, {max, _}} =
          elem
          |> Enum.frequencies()
          |> Enum.min_max_by(fn {_k, v} -> v end)

        %{acc | gamma: acc.gamma ++ [max], epsilon: acc.epsilon ++ [min]}
      end)

    gamma = decimal_from_binary_int(raw_gamma)
    epsilon = decimal_from_binary_int(raw_epsilon)

    %Result{data | gamma: gamma, epsilon: epsilon}
  end

  defp sum_result(%Result{gamma: gamma, epsilon: epsilon}), do: gamma * epsilon

  defp decimal_from_binary_int(num) do
    num |> Enum.map(&String.to_integer/1) |> Integer.undigits(2)
  end
end
