defmodule Aoc2021.Day02Test do
  use ExUnit.Case

  alias Aoc2021.{Day02, Utils}

  describe "part one" do
    test "sample input" do
      input = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

      assert Day02.part_one(input) == 150
    end

    test "unique input" do
      input = Utils.read_file("inputs/day02.txt")

      assert Day02.part_one(input) == 1_936_494
    end
  end

  describe "part two" do
    test "sample input" do
      input = ["forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"]

      assert Day02.part_two(input) == 900
    end
  end
end
