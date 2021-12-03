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

    gamma = raw_gamma |> Enum.map(&String.to_integer/1) |> Integer.undigits(2)
    epsilon = raw_epsilon |> Enum.map(&String.to_integer/1) |> Integer.undigits(2)

    %Result{data | gamma: gamma, epsilon: epsilon}
  end

  defp sum_result(%Result{gamma: gamma, epsilon: epsilon}), do: gamma * epsilon
end
