defmodule Lambda do
  def test do
    fn(x) -> x + 3 end.(5)
  end
end

IO.puts(Lambda.test())
