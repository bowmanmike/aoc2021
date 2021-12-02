defmodule Aoc2021.Day02Test do
  use ExUnit.Case

  alias Aoc2021.{Day02, Utils}

  test "sample input" do
    input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

    assert Day02.run(input) == 5
  end

  test "unique input" do
    input = Utils.read_file("inputs/day02.txt")

    assert Day02.run(input) == 1761
  end
end
