defmodule Derivate do
@type literal() :: {:num, number()}
                  | {:var, atom()}

@type expr() :: {:add, expr(), expr()}
                | {:mul, expr(), expr()}
                | {:exp, expr(), literal()}
                | literal()

  def test() do
    e = {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 2}}
    e2 = {:add, {:mul, {:num, 2}, {:exp, {:var, :x}, {:num, 3}}}, {:num, 2}}

    d = deriv(e, :x)
    d2 = deriv(e2, :x)

    IO.write("original expression: #{inspect e}\n")
    IO.write("readable expression: #{inspect make_readable(e)}\n")
    IO.write("derivative: #{inspect make_readable(d)}\n")
    IO.write("simplified: #{inspect make_readable(simplify(d))}\n\n")

    IO.write("original expression 2: #{inspect e2}\n")
    IO.write("readable expression 2: #{inspect make_readable(e2)}\n")
    IO.write("derivative 2: #{inspect make_readable(d2)}\n")
    IO.write("simplified 2: #{inspect make_readable(simplify(d2))}\n")
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:add, e1, e2}, v) do
      {:add, deriv(e1, v), deriv(e2, v)}
  end
  def deriv({:mul, e1, e2}, v) do
      {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
  end
  def deriv({:exp, e, l}, v) do
      {:mul, deriv(e, v), {:mul, {:exp, e, {:add, l, {:num, -1}}}, l}}
  end

  def simplify({:add, e1, e2}) do simplify_add({:add, simplify(e1), simplify(e2)}) end
  def simplify({:mul, e1, e2}) do simplify_mul({:mul, simplify(e1), simplify(e2)}) end
  def simplify({:exp, e, l}) do simplify_exp({:exp, simplify(e), simplify(l)}) end
  def simplify(e) do e end

  def simplify_add({:add, e1, {:num, 0}}) do e1 end
  def simplify_add({:add, {:num, 0}, e2}) do e2 end
  def simplify_add({:add, {:num, n1}, {:num, n2}}) do {:num, n1 + n2} end
  def simplify_add({:add, e1, e2}) do {:add, e1, e2} end

  def simplify_mul({:mul, _, {:num, 0}}) do {:num, 0} end
  def simplify_mul({:mul, {:num, 0}, _}) do {:num, 0} end
  def simplify_mul({:mul, e1, {:num, 1}}) do e1 end
  def simplify_mul({:mul, {:num, 1}, e2}) do e2 end
  def simplify_mul({:mul, {:num, n1}, {:num, n2}}) do {:num, n1 * n2} end
  def simplify_mul({:mul, {:num, n1}, {:mul, {:num, n2}, e2}}) do {:mul, {:num, n1 * n2}, e2} end
  def simplify_mul({:mul, {:num, n1}, {:mul, e1, {:num, n2}}}) do {:mul, {:num, n1 * n2}, e1} end
  def simplify_mul({:mul, {:mul, {:num, n1}, e2}, {:num, n2},}) do {:mul, {:num, n1 * n2}, e2} end
  def simplify_mul({:mul, {:mul, e1, {:num, n1}}, {:num, n2},}) do {:mul, {:num, n1 * n2}, e1} end
  def simplify_mul({:mul, e1, e2}) do {:mul, e1, e2} end

  def simplify_exp({:exp, _, 0}) do {:num, 1} end
  def simplify_exp({:exp, e, 1}) do e end
  def simplify_exp({:exp, e, l}) do {:exp, e, l} end

  def make_readable({:num, n}) do "#{n}" end
  def make_readable({:var, v}) do "#{v}" end
  def make_readable({:add, e1, e2}) do "#{make_readable(e1)} + #{make_readable(e2)}" end
  def make_readable({:mul, e1, e2}) do "#{make_readable(e1)} * #{make_readable(e2)}" end
  def make_readable({:exp, e, l}) do "#{make_readable(e)}^(#{make_readable(l)})" end
end

Derivate.test()
