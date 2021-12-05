defmodule Aoc2021.Day04 do
  @marker "0"

  def part_one(input) do
    [numbers, boards] = String.split(input, "\n", parts: 2, trim: true)

    numbers = parse_numbers(numbers)
    boards = parse_boards(boards)

    numbers
    |> Enum.with_index()
    |> Enum.reduce_while(boards, fn input, boards -> handle_number(input, boards) end)
  end

  def part_two(input) do
    input
  end

  defp handle_number({number, index}, boards) when index < 6 do
    {:cont, mark_board(number, boards)}
  end

  defp handle_number({number, _index}, boards) do
    marked_boards = mark_board(number, boards)

    case check_for_winner(marked_boards) do
      false -> {:cont, marked_boards}
      true -> {:halt, calc_result(marked_boards, number)}
    end
  end

  defp calc_result(boards, number) do
    sum =
      boards
      |> Enum.find(&check_board/1)
      |> Enum.flat_map(fn elem ->
        elem
        |> Enum.reject(&String.starts_with?(&1, @marker))
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.sum()

    sum * String.to_integer(number)
  end

  defp check_for_winner(boards) do
    Enum.any?(boards, fn board ->
      check_board(board)
    end)
  end

  defp check_board(board) do
    board
    |> Enum.with_index()
    |> Enum.any?(fn {row, index} ->
      check_row(row) || check_column(board, index)
    end)
  end

  defp check_row(row) do
    Enum.all?(row, fn number ->
      String.starts_with?(number, @marker)
    end)
  end

  defp check_column(board, index) do
    Enum.all?(board, fn row ->
      String.starts_with?(Enum.at(row, index), @marker)
    end)
  end

  defp mark_board(number, boards) do
    Enum.map(boards, fn board ->
      Enum.map(board, fn
        row ->
          row
          |> Enum.map(fn
            ^number -> "#{@marker}#{number}"
            num -> num
          end)
      end)
    end)
  end

  defp parse_numbers(numbers) do
    numbers
    |> String.split(",")
  end

  defp parse_boards(boards) do
    boards
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(5)
    |> Enum.map(fn board ->
      Enum.map(board, fn row -> String.split(row, " ", trim: true) end)
    end)
  end
end
