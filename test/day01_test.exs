defmodule Aoc2021.Day01Test do
  use ExUnit.Case

  alias Aoc2021.{Day01, Utils}

  describe "foo" do
    test "example input" do
      input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

      assert Day01.run(input) == 7
    end

    test "unique input" do
      input = Utils.read_file("inputs/day01.txt")

      assert Day01.run(input) == 1709
    end
  end
end
