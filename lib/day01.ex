defmodule Aoc2021.Day01 do

  def run(input) do
    input
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce(0, fn
      [first, second], acc when first < second -> acc + 1
      _, acc -> acc
    end)
  end
end
