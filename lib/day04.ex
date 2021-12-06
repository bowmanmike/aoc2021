defmodule Aoc2021.Day04 do
  @marker "0"

  def part_one(input) do
    {numbers, boards} = setup(input)

    numbers
    |> Enum.with_index()
    |> Enum.reduce_while(boards, &handle_number/2)
  end

  def part_two(input) do
    {numbers, boards} = setup(input)

    numbers
    |> Enum.with_index()
    |> Enum.reduce_while(boards, &handle_part_two/2)
  end

  defp setup(input) do
    [numbers, boards] = String.split(input, "\n", parts: 2, trim: true)

    numbers = parse_numbers(numbers)
    boards = parse_boards(boards)

    {numbers, boards}
  end

  defp handle_part_two({number, index}, boards) when index < 5 do
    {:cont, mark_board(number, boards)}
  end

  defp handle_part_two({number, _index}, [_final_board] = boards) do
    marked_boards = mark_board(number, boards)

    case check_for_winner(marked_boards) do
      false -> {:cont, boards}
      true -> {:halt, calc_result(marked_boards, number)}
    end
  end

  defp handle_part_two({number, _index}, boards) do
    marked_boards = mark_board(number, boards)
    remaining_boards = Enum.reject(marked_boards, fn board -> check_board(board) end)

    case check_for_winner(remaining_boards) do
      false -> {:cont, remaining_boards}
      true -> {:halt, calc_result(remaining_boards, number)}
    end
  end

  defp handle_number({number, index}, boards) when index < 5 do
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

  def check_for_winner([board]), do: check_board(board)

  def check_for_winner(boards) do
    Enum.any?(boards, fn board ->
      check_board(board)
    end)
  end

  def check_board(board) do
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
