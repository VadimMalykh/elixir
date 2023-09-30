defmodule Recursion do

  def mapsum(l, f) do
    ms(l, 0, f)
  end

  def max([head | tail]) do
    mx(tail, head)
  end

  def caesar([], _n), do: []
  def caesar([head | tail], n) do
    [z | _] = 'z'
    [a | _] = 'A'
    next =
      if head + n > z do
        a + (head + n - z) - 1
      else
        head + n
      end
    [next | caesar(tail, n)]
  end

  defp ms([], a, _f), do: a
  defp ms([head | tail], a, f) do
    ms(tail, a + f.(head), f)
  end

  defp mx([], a), do: a
  defp mx([head | tail], a) do
    if head > a do
      mx(tail, head)
    else
      mx(tail, a)
    end
  end
end
