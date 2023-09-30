defmodule MyStreams do

  def line_lengths!(filename) do
    File.stream!(filename)
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(filename) do
    File.stream!(filename)
    |> Stream.map(&String.length/1)
    |> Enum.reduce(0, &(if &1 < &2, do: &2, else: &1))
  end

  def longest_line!(filename) do
    File.stream!(filename)
    |> Enum.reduce("", &(if String.length(&1) < String.length(&2), do: &2, else: &1))
  end

  def words_per_line!(filename) do
    File.stream!(filename)
    |> Enum.map(&length(String.split(&1)))
  end

end
