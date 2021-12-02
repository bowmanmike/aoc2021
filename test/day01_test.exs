defmodule Aoc2021.Day01Test do
  use ExUnit.Case

  alias Aoc2021.{Day01, Utils}

  describe "part one" do
    test "example input" do
      input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

      assert Day01.run_part_one(input) == 7
    end

    test "unique input" do
      input = Utils.read_file("inputs/day01.txt") |> Enum.map(&String.to_integer/1)

      assert Day01.run_part_one(input) == 1709
    end
  end

  describe "part two" do
    test "sample input" do
      input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

      assert Day01.run_part_two(input) == 5
    end

    test "unique input" do
      input = Utils.read_file("inputs/day01.txt") |> Enum.map(&String.to_integer/1)

      assert Day01.run_part_two(input) == 1761
    end
  end
end
