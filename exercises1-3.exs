defmodule Test do
  def double(n) do
      ((n - 32)/1.8)
  end

  def area(a, b) do
    a * b
  end

  def sqarea(n) do
    Test.area(n,n)
  end

  def circlearea(r) do
    :math.pow(r, 2) * :math.pi
  end

  def product(m,n) do
    if m == 0 do
      0
    else
      n + Test.product(m-1, n)
    end
  end

  def product_case(m,n) do
    case m do
      0 ->
        0
      _ ->
        n + Test.product(m-1, n)
    end
  end

  def exp(x, n) do
    case n do
      0 ->
        1
      _ ->
        Test.product(x, Test.exp(x, n-1))
    end
  end

  def exp_full(x, n) do
    cond do
    n == 1 ->
      x
    rem(trunc(n),2) == 0 ->
      Test.exp_full(x, n/2) * Test.exp_full(x, n/2)
    true ->
      x * Test.exp_full(x, n-1)
    end

  end
end


IO.puts(Test.double(100))
IO.puts(Test.area(5,6))
IO.puts(Test.sqarea(5))
IO.puts(Test.circlearea(5))
IO.puts(Test.product(5,6))
IO.puts(Test.product_case(5,6))
IO.puts(Test.exp(8,2))
IO.puts(Test.exp_full(2,4))
