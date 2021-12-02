defmodule Aoc2021.Utils do
  def read_file(path) do
    path
    |> Path.expand()
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
