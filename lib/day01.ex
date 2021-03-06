defmodule Aoc2021.Day01 do
  def run_part_one(input) do
    input
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(0, fn
      [first, second], acc when first < second -> acc + 1
      _, acc -> acc
    end)
  end

  def run_part_two(input) do
    input
    |> Enum.chunk_every(3, 1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(0, fn
      [first, second], acc when first < second -> acc + 1
      _, acc -> acc
    end)
  end
end
