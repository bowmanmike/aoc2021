defmodule Aoc2021.Day05 do
  defmodule Entry do
    defstruct [:start, :finish]
  end

  defmodule Point do
    defstruct [:x, :y]
  end

  defmodule Grid do
    defstruct [:grid]

    def build_from_entries(entries) do
      max_x =
        entries
        |> Enum.flat_map(fn %{start: %{x: x1}, finish: %{x: x2}} -> [x1, x2] end)
        |> Enum.max()

      max_y =
        entries
        |> Enum.flat_map(fn %{start: %{y: y1}, finish: %{y: y2}} -> [y1, y2] end)
        |> Enum.max()

      grid = List.duplicate(List.duplicate(0, max_y + 1), max_x + 1)
      %__MODULE__{grid: grid}
    end

    def mark_line(%{grid: grid}, %Entry{
          start: %{x: start_x, y: start_y},
          finish: %{x: finish_x, y: finish_y}
        }) do
      for x <- start_x..finish_x,
          y <- start_y..finish_y,
          reduce: grid do
        acc -> update_in(acc, [Access.at(y), Access.at(x)], &(&1 + 1))
      end
    end

    # {9,7} -> {7,9}
    def mark_line_two(%{grid: grid}, %{start: %{x: x, y: y}, finish: %{x: y, y: x}}) do
      x..y
      |> Enum.to_list()
      |> Enum.zip(Enum.to_list(y..x))
      |> Enum.reduce(grid, fn {x, y}, acc ->
        update_in(acc, [Access.at(y), Access.at(x)], &(&1 + 1))
      end)
    end

    # {0, 0} -> {8, 8}
    def mark_line_two(%{grid: grid}, %{
          start: %{x: start, y: start},
          finish: %{x: finish, y: finish}
        }) do
      for num <- start..finish, reduce: grid do
        acc -> update_in(acc, [Access.at(num), Access.at(num)], &(&1 + 1))
      end
    end

    # {3, 4} -> {1, 4}
    def mark_line_two(%{grid: grid}, %Entry{
          start: %{x: start_x, y: start_y},
          finish: %{x: finish_x, y: finish_y}
        }) do
      for x <- start_x..finish_x,
          y <- start_y..finish_y,
          reduce: grid do
        acc -> update_in(acc, [Access.at(y), Access.at(x)], &(&1 + 1))
      end
    end

    def sum_multiples(%{grid: grid}) do
      grid
      |> List.flatten()
      |> Enum.reduce(0, fn
        elem, acc when elem >= 2 -> acc + 1
        _elem, acc -> acc
      end)
    end
  end

  def part_one(input) do
    parsed_input =
      setup(input)
      |> Enum.filter(fn
        %Entry{start: %Point{x: x}, finish: %Point{x: x}} -> true
        %Entry{start: %Point{y: y}, finish: %Point{y: y}} -> true
        _ -> false
      end)

    base_grid = Grid.build_from_entries(parsed_input)

    parsed_input
    |> Enum.reduce(base_grid, fn entry, grid ->
      new_grid = Grid.mark_line(grid, entry)
      %{grid | grid: new_grid}
    end)
    |> Grid.sum_multiples()
  end

  def part_two(input) do
    parsed_input =
      setup(input)
      |> Enum.filter(fn
        %Entry{start: %Point{x: x}, finish: %Point{x: x}} -> true
        %Entry{start: %Point{y: y}, finish: %Point{y: y}} -> true
        %Entry{start: %Point{x: start, y: start}, finish: %Point{x: finish, y: finish}} -> true
        %Entry{start: %Point{x: x, y: y}, finish: %Point{x: y, y: x}} -> true
        _ -> false
      end)

    base_grid = Grid.build_from_entries(parsed_input)

    parsed_input
    |> Enum.reduce(base_grid, fn entry, grid ->
      new_grid = Grid.mark_line_two(grid, entry)
      %{grid | grid: new_grid}
    end)
    |> Grid.sum_multiples()
  end

  defp setup(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn elem ->
      [start, finish] =
        elem
        |> String.split(" -> ")
        |> Enum.map(fn point ->
          [x, y] = String.split(point, ",", trim: true)
          %Point{x: String.to_integer(x), y: String.to_integer(y)}
        end)

      %Entry{start: start, finish: finish}
    end)
  end
end
