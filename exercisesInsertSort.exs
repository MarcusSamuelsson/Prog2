defmodule Test3 do
  def isort(l) do
    isort(l, [])
  end

  def insert(e, l) do
    [head | tail] = l

    if e <= head do
      if head != [] && head != nil do
        [e] ++ l
      end
    else
      if tail != [] && tail != nil do
        [head] ++ insert(e, tail)
      else
        l ++ [e]
      end
    end
  end

  def isort(l, sorted) do
    if l != [] && l != nil do
      [head | tail] = l

      case sorted do
        [] ->
          sorted ++ isort(tail, [head])
        [_h | _t] ->
          newsorted = insert(head, sorted)

          if tail != [] do
            isort(tail, newsorted)
          else
             newsorted
          end
      end
    end
  end
end

IO.inspect(Test3.isort([47,42,26,44,55,26,37,48,69,23]), charlists: :as_lists)
