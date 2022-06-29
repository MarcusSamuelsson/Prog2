defmodule Test2 do
    def nth(n, l) do
      [head | tail] = l;

      if n <= 1 do
        head
      else
        nth(n-1, tail)
      end

    end

    def len(l) do
      [head | tail] = l;


      if tail == [] do
        1
      else
        1 + len(tail)
      end
    end

    def sum(l) do
      [head | tail] = l;


      if tail == [] do
        head
      else
        head + sum(tail)
      end
    end

    def duplicate(l) do
      [head | tail] = l;


      if tail == [] do
        [head]
      else
        [head] ++ duplicate(tail)
      end
    end

    def add(x, l) do
      [head | tail] = l;


      cond do
        head == x ->
          [head | tail]
        tail == [] ->
          [head] ++ [x]
        true ->
          [head] ++ add(x ,tail)
      end
    end

    def remove(x, l) do
      if l != [] do
        [head | tail] = l;

        cond do
          head == x ->
            if tail != [] && tail != nil do
              remove(x ,tail)
            end
          tail == [] ->
            [head]
          true ->
            [head] ++ remove(x, tail)
        end
      end
    end

    def unique(nil) do end
    def unique(l) do
      [head | tail] = l;
      newtail = remove(head, tail)

      cond do
        newtail == [] || newtail == nil ->
            [head]
        true ->
            [head] ++ unique(newtail)
      end
    end

    def create_single_list(x, s) do
      if s > 0 do
        [x] ++ create_single_list(x, s-1)
      else
        [x]
      end
    end

    def pack(l) do
      [head | tail] = l

      if tail != [] && tail != nil do
        newtail = remove(head, tail)

        if newtail != [] && newtail != nil do
          tot_in_pack = len(tail) - len(newtail)
          [create_single_list(head, tot_in_pack)] ++ pack(newtail)
        else
          [create_single_list(head, len(tail))]
        end
      end
    end

    def reverse(l) do
      [head | tail] = l

      if tail != [] && tail != nil do
        reverse(tail) ++ [head]
      else
        [head]
      end
    end
end

IO.puts(Test2.nth(5, [47,42,26,44,55,26,37,48,69]))
IO.puts(Test2.len([47,42,26,44,55,26,37,48,69]))
IO.puts(Test2.sum([2,2,2,2,2,2,2,2,2]))
IO.inspect(Test2.duplicate([47,42,26,44,55,26,37,48,69]), charlists: :as_lists)
IO.inspect(Test2.add(7,[47,42,26,44,55,26,37,48,69]), charlists: :as_lists)
IO.inspect(Test2.remove(55,[47,42,26,44,55,26,37,55,69]), charlists: :as_lists)
IO.inspect(Test2.unique([44,26,44,55,23,26,55,23]), charlists: :as_lists)
IO.inspect(Test2.pack([44,26,44,55,23,26,55,23,44,23]), charlists: :as_lists)
IO.inspect(Test2.reverse([1,2,3,4,5,6]), charlists: :as_lists)
