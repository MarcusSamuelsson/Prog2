defmodule Tenta do
  #upp 1
  def toggle([]) do end
  def toggle([h1, h2|t]) do
    [h2, h1| toggle(t)]
  end
  def toggle(h) do h end

  #upp 2
  def push(e, l) do
    [e] ++ l
  end

  def pop([]) do :no end
  def pop([h|t]) do
    {:ok, h, t}
  end

  #upp 3
  def flatten([]) do [] end
  def flatten([h|t]) do  flatten(h) ++ flatten(t) end
  def flatten(h) do [h] end

  #upp 4
  def index(inpt) do index(inpt, 0) end

  def index([head|tail], h) when head > h do index(tail, h+1) end
  def index(_, h) do h end

  #upp 5
  @type tree() :: :nil | {:node, tree(), tree()} | {:leaf, any()}

  def compact(:nil) do :nil end
  def compact({:leaf, v}) do {:leaf, v} end
  def compact({:node, left, right}) do
    ll = compact(left)
    rl = compact(right)
    compress(ll, rl)
  end

  def compress(:nil, {:leaf, v}) do {:leaf, v} end
  def compress({:leaf, v}, :nil) do {:leaf, v} end
  def compress({:leaf, v}, {:leaf, v}) do {:leaf, v} end
  def compress({:leaf, v1}, {:leaf, v2}) do {:node, {:leaf, v1}, {:leaf, v2}} end

  #upp 7
  @type next() :: {:ok, integer(), ( -> next())}
  @spec primes() :: ( -> next())

  def primes() do
    fn() -> {:ok, 2, fn() -> sieve(2, fn -> next(3) end) end} end
  end

  def next(n) do
    {:ok, n, fn() -> next(n+1) end}
  end

  def sieve(p, f) do
      {:ok, n, f} = f.()
      if rem(n,p) == 0 do
        sieve(p, f)
      else
        {:ok, n, fn() -> sieve(n, fn() -> sieve(p,f) end) end}
      end
  end

end

IO.inspect(Tenta.toggle([:a,:b,:c,:d,:e,:f,:g]), charlists: :as_lists)
IO.inspect(Tenta.push(:z, [:a,:b,:c,:d,:e,:f,:g]), charlists: :as_lists)
IO.inspect(Tenta.pop([:a,:b,:c,:d,:e,:f,:g]), charlists: :as_lists)
IO.inspect(Tenta.pop([]), charlists: :as_lists)
IO.inspect(Tenta.flatten([1,[2],[[3,[4,5]],6]]), charlists: :as_lists)
IO.inspect(Tenta.index([12,10,8,8,6,4,4,4,2]), charlists: :as_lists)
IO.inspect(Tenta.compact({:node, {:leaf, 4}, {:leaf, 4}}), charlists: :as_lists)
IO.inspect(Tenta.compact({:node, {:leaf, 5}, {:node, :nil, {:leaf, 4}}}), charlists: :as_lists)
IO.inspect(Tenta.primes(), charlists: :as_lists)
