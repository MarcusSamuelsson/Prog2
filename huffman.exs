defmodule Huffman do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text()  do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    #decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    #decode(seq, decode)

    IO.write("sample text: #{inspect sample}\n\n")
    IO.write("tree: #{inspect tree}\n\n")
    IO.write("encode table: #{inspect encode}\n\n")
    IO.write("text: #{inspect text}\n\n")
    IO.write("encoded: #{inspect seq}\n")
  end

  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end

  def huffman([{t,f}|[]]) do {t,f} end
  def huffman(freq) do
      new_freq = huffman(freq, :nil, :nil)
      huffman(new_freq)
  end

  def huffman([], {c1, f1}, {c2, f2}) do [{{{c1, f1}, {c2, f2}}, f1+f2}] end
  def huffman([{c1, f1}, {c2, f2}|t], :nil, :nil) do
    if(f1 > f2) do
      huffman(t, {c1, f1}, {c2, f2})
    else
      huffman(t, {c2, f2}, {c1, f1})
    end
  end

  def huffman([{c, f}|t], {c1, f1}, {c2, f2}) do
    cond do
      (f <= f2) ->
        [{c1, f1}] ++ huffman(t, {c2, f2}, {c, f})
      (f < f1) ->
        [{c1, f1}] ++ huffman(t, {c, f}, {c2, f2})
      true ->
        [{c, f}] ++ huffman(t, {c1, f1}, {c2, f2})
    end
  end

  def encode_table(tree) do
    encode_table(tree, [])
  end

  def encode_table({{{{t1, fi1}, f1}, {{t2, fi2}, f2}}, _}, l) do encode_table({{t2, fi2}, f2}, (l++[0])) ++ encode_table({{t1, fi1}, f1}, (l++[1])) end
  def encode_table({{{c, _}, {{t, fi}, f2}}, _}, l) do [{c, (l++[1])}] ++ encode_table({{t, fi}, f2}, (l++[0])) end
  def encode_table({{{{t, fi}, f1}, {c, _}}, _}, l) do  [{c, (l++[0])}] ++ encode_table({{t, fi}, f1}, (l++[1])) end
  def encode_table({{{c1, _}, {c2, _}}, _}, l) do [{c2, (l++[0])}] ++ [{c1, (l++[1])}] end

  #def decode_table(tree) do
    # To implement...
  #end

  def encode(text, table) do
    encode(text, table, [])
  end

  def encode([], _table, l) do l end
  def encode([h|t], table, l) do encode(t, table, l ++ encode_letter(h, table)) end

  def encode_letter(c, [{c, e}|tail]) do e end
  def encode_letter(c, [{h, e}|tail]) do encode_letter(c, tail) end
  def encode_letter(c, {c, e}) do e end

  def decode(seq, tree) do
    # To implement...
  end

  def freq(sample) do
    freq(sample, [])
  end

  def freq([], freq) do freq end
  def freq([char | rest], freq) do
    freq_new = [] ++ freq_updt(char, freq)
    freq(rest, freq_new)
  end

  def freq_updt(char, []) do [{char, 1}] end
  def freq_updt(char, [{char, f}|t]) do [{char, f+1}|t] end
  def freq_updt(char, [{c, f}|t]) do [{c, f}] ++ freq_updt(char, t) end
end

Huffman.test()
