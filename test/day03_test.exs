defmodule Aoc2021.Day03Test do
  use ExUnit.Case

  alias Aoc2021.{Day03, Utils}

  describe "part one" do
    test "example input" do
      input = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
      ]

      assert Day03.part_one(input) == 198
    end

    test "unique input" do
      input = Utils.read_file("inputs/day03.txt")

      assert Day03.part_one(input) == 749_376
    end
  end
end
