defmodule Aoc2021.Day05 do
  defmodule Entry do
    defstruct [:start, :finish]
  end

  def part_one(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn elem ->
      [start, finish] = String.split(elem, " -> ")

      %Entry{start: String.to_float(start), finish: String.to_float(finish)}
    end)
  end
end
