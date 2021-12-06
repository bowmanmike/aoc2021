defmodule Aoc2021.Day05Test do
  use ExUnit.Case

  alias Aoc2021.Day05

  @sample_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "part one" do
    test "sample input" do
      assert Day05.part_one(@sample_input) == 5
    end
  end
end
