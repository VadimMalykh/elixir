defmodule M do
  def main do
    data_stuff()
  end

  def data_stuff do
    my_int = 123
    IO.puts "Integer #{is_integer(my_int)}"
  end
end

defmodule Chop do

  def guess(actual, a.._b) when actual == a, do: a

  def guess(actual, _a..b) when actual == b, do: b

  def guess(actual, a..b) when a+div(b-a,2) < actual do
    IO.puts "Is it #{a+div(b-a,2)}? (#{a}..#{b})"
    guess(actual, a+div(b-a,2)..b)
  end

  def guess(actual, a..b) when a+div(b-a,2) > actual do
    IO.puts "Is it #{a+div(b-a,2)}? (#{a}..#{b})"
    guess(actual, a..a+div(b-a,2))
  end

  def guess(_actual, a..b), do: a+div(b-a,2)

end
