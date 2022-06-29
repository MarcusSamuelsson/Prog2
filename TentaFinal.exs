defmodule TentaFinal do
  def start() do
    r = [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}]
    pc = 0
    commands = [{:addi,1,0,10}, {:addi,3,0,1}, {:out,3}, {:addi,1,1,-1}, {:addi,4,3,0}, {:add,3,2,3}, {:out,3}, {:beq,1,0,3}, {:addi,2,4,0}, {:beq,0,0,-6}, {:halt}]
    c = getcommand(commands, pc)
    call(c, r, pc, [], commands)
  end

  def getcommand([h|_t], 0) do IO.write("sample text: #{inspect h}\n\n"); h end
  def getcommand([_h|t], n) do getcommand(t, n-1) end

  def call({:addi, x, y, z}, r, pc, l, com) do
    newr = addi(x, y, z, r)
    c = getcommand(com, pc+1)
    call(c, newr, pc+1, l, com)
  end
  def call({:add, x, y, z}, r, pc, l, com) do
    newr = add(x, y, z, r)
    c = getcommand(com, pc+1)
    call(c, newr, pc+1, l, com)
  end
  def call({:out, x}, r, pc, l, com) do
    {newr, n} = out(x, r)
    c = getcommand(com, pc+1)
    call(c, newr, pc+1, l ++ [n], com)
  end
  def call({:beq, x, y, z}, r, pc, l, com) do
    {newr, off} = beq(x, y, z, r)
    c = getcommand(com, pc+off)
    call(c, newr, pc+off, l, com)
  end
  def call({:halt}, _r, _pc, l, _com) do l end

  def add(d, s1, s2, [{d,n}|t]) do
    newn = match(s1,[{d,n}|t]) + match(s2,[{d,n}|t])
    [{d,newn}|t]
  end
  def add(d, s1, s2, [{x,n}|t]) do add(d, s1, s2, t ++ [{x,n}]) end

  def addi(d, s1, imm, [{d,n}|t]) do
    newn = match(s1,[{d,n}|t]) + imm
    [{d,newn}|t]
  end
  def addi(d, s1, imm, [{x,n}|t]) do addi(d, s1, imm, t ++ [{x,n}]) end

  def beq(s1, s2, offset, r) do
    x = match(s1, r)
    y = match(s2, r)

    if x == y do
      {r, offset}
    else
      {r, 1}
    end
  end

  def out(s1, [{s1,n}|t]) do {[{s1,n}|t], n} end
  def out(s1, [{d,n}|t]) do out(s1,t ++ {d,n}) end

  def match(s, [{s,n}|_]) do n end
  def match(s, [{x,n}|t]) do match(s, t ++ [{x,n}]) end
end

IO.inspect(TentaFinal.start(), charlists: :as_lists)
