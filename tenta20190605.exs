defmodule Tenta2 do
  #upp 1
  def drop([], _) do [] end
  def drop([h|t], 1) do t end
  def drop([h|t], n) do
    [h] ++ drop(t, n-1)
  end

  #upp 2
  def rotate(l, n) do
    rotate(l, n, [])
  end

  #Should be append()
  def rotate(l1, 0, l2) do l1 ++ Enum.reverse(l2) end
  def rotate([h|t], n, l) do
    rotate(t, n-1, [h|l])
  end

  #upp 3
  @type tree() :: {:leaf, any()} | {:node, tree(), tree()}

  def nth(1, {:leaf, val}) do {:found, val} end
  def nth(n, {:leaf, _}) do {:cont, n-1} end
  def nth(n, {:node, left, right}) do
    case nth(n, left) do
      {:found, val} ->
        {:found, val}
      {:cont, k} ->
        nth(k, right)
    end
  end

  #upp 4
  @type op() :: :add | :sub
  @type instr() :: integer() | op()
  @type seq() :: [instr()]

  def hp35([n|[]]) do n end
  def hp35([n1, n2, op|t]) do
      if op == :add do
        hp35([n1+n2|t])
      else
        hp35([n1-n2|t])
      end
  end

  #upp 5
  def pascal(1) do [1] end
  def pascal(n) do [1|next(pascal(n-1))] end

  def next([1]) do [1] end
  def next([h|t]) do
      [b|_] = t

      IO.inspect("what is this: " + b, charlists: :as_lists)
      [h+b|next(t)]
  end

end

IO.inspect(Tenta2.drop([:a,:b,:c,:d,:e,:f,:g,:h,:i,:j], 3), charlists: :as_lists)
IO.inspect(Tenta2.rotate([:a,:b,:c,:d,:e], 4), charlists: :as_lists)
IO.inspect(Tenta2.nth(4, {:node, {:node, {:leaf, :a}, {:leaf, :b}}, {:leaf, :c}}), charlists: :as_lists)
IO.inspect(Tenta2.hp35([3, 4, :add, 2, :sub]), charlists: :as_lists)
IO.inspect(Tenta2.hp35([3, 4, :add]), charlists: :as_lists)
IO.inspect(Tenta2.hp35([3, 4, :add, 2, :sub, 2, :sub, 2, :sub]), charlists: :as_lists)
IO.inspect(Tenta2.pascal(5), charlists: :as_lists)
