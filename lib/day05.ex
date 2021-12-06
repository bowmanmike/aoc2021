defmodule Aoc2021.Day05 do
  defmodule Entry do
    defstruct [:start, :finish]
  end

  defmodule Point do
    defstruct [:x, :y]
  end

  def part_one(input) do
    parsed_input =
      setup(input)
      |> Enum.filter(fn
        %Entry{start: %Point{x: x}, finish: %Point{x: x}} -> true
        %Entry{start: %Point{y: y}, finish: %Point{y: y}} -> true
        _ -> false
      end)

    # require IEx
    # IEx.pry()

    Enum.map(parsed_input, fn entry ->
      generate_list_coords(entry)
    end)

    parsed_input
  end

  defp generate_list_coords(%Entry{
         start: %{x: start_x, y: start_y},
         finish: %{x: end_x, y: end_y}
       }) do
    require IEx
    IEx.pry()
  end

  defp setup(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn elem ->
      [start, finish] =
        elem
        |> String.split(" -> ")
        |> IO.inspect()
        |> Enum.map(fn point ->
          [x, y] = String.split(point, ",", trim: true)
          %Point{x: String.to_integer(x), y: String.to_integer(y)}
        end)

      %Entry{start: start, finish: finish}
    end)
  end
end
