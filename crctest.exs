defmodule Crcquiz do
  def crc(l) do
    IO.inspect(l, charlists: :as_lists)
    crc_work(l++[0,0,0])
  end


  def crc_work([a,b,c|[]]) do [a,b,c] end
  def crc_work([a,b,c,d|t]) do
    if a == 0 do
      crc_work([b,c,d] ++ t)
    else
      n1 = xor(a, 1)
      n2 = xor(b, 0)
      n3 = xor(c, 1)
      n4 = xor(d, 1)

      crc_work([n1,n2,n3,n4] ++ t)
    end
  end

  def xor(n1, n2) do
    if n1 == n2 do
      0
    else
      1
    end
  end
end

IO.inspect(Crcquiz.crc([1,1,0,1,0,1,0,1,1,1,0,1,0,0,1,1,1]), charlists: :as_lists)
