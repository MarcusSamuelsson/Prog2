defmodule Test4 do
  def msort(l) do
    case l do
      [h] ->
        [h]
      [_h|_t] ->
        {left, right} = msplit(l, [], [])
        merge(msort(left), msort(right))
    end
  end

  def merge([], y) do y end
  def merge(x, []) do x end
  def merge([h|t], [head|tail]) do
    IO.inspect({[h|t],[head|tail]}, charlists: :as_lists)

    if h < head do
      [h] ++ merge(t, [head|tail])
    else
      [head] ++ merge([h|t], tail)
    end
  end

  def msplit([], x, y) do {x, y} end
  def msplit([last], x, y) do {[last|x], y} end
  def msplit([h1, h2|t], x, y) do
    msplit(t, [h1|x], [h2|y])
  end
end

IO.inspect(Test4.msort([47,42,26,44,55,26,37,48,69,23]), charlists: :as_lists)
