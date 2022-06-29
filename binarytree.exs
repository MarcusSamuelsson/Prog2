defmodule Btree do
  def add(key, value, :nil) do {:node, key, value, :nil, :nil} end
  def add(key, value, {:node, k, v, left, right}) do
    cond do
      key < k ->
        {:node, k, v, add(key, value, left), right}
      true ->
        {:node, k, v, left, add(key, value, right)}
    end
  end

  def remove(key, {:node, key, _, :nil, :nil}) do :nill end
  def remove(key, {:node, key, _, left, :nil}) do left end
  def remove(key, {:node, key, _, :nil, right}) do right end
  def remove(key, {:node, key, _, left, right}) do {:node, left, right} end
  def remove(key, {:node, k, value, left, right}) do
    cond do
      key < k ->
        {:node, k, value, remove(key, left), right}
      true ->
        {:node, k, value, left, remove(key, right)}
    end
  end

  def modify(_, _, :nil) do :nil end
  def modify(key, value, {:node, key, _, left, right}) do {:node, key, value, left, right} end
  def modify(key, value, {:node, k, _, left, right}) do
    cond do
      key < k ->
        {:node, k, value, modify(key, value, left), right}
      true ->
        {:node, k, value, left, modify(key, value, right)}
      end
  end

  #def lookup(key, node) do end
  def lookup(_, :nil) do :no end
  def lookup(key, {:node, key, _v, _, _}) do :yes end
  def lookup(key, {:node, k, _v, left, right}) do
    cond do
      key < k ->
        lookup(key, left)
      true ->
        lookup(key, right)
    end
  end
end



IO.inspect(Btree.add(:c, 12, {:node, :b, 1, :nil, {:node, :f, 2, :nil, :nil}}))
IO.inspect(Btree.add(:c, 12, {:node, :d, 1, :nil, :nil}))
IO.inspect(Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}}))
IO.inspect(Btree.lookup(:b, Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}})))
IO.inspect(Btree.remove(:a, Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}})))
IO.inspect(Btree.remove(:b, Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}})))
IO.inspect(Btree.remove(:f, Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}})))
IO.inspect(Btree.modify(:c, 14, Btree.add(:c, 12, {:node, :b, 1, {:node, :a, 3, :nil, :nil}, {:node, :f, 2, :nil, :nil}})))
