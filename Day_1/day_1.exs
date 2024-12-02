# ---------------------------Common----------------------------------

{left, right} =
  File.stream!("input.txt", :line)
  |> Stream.map(&String.trim/1)
  |> Stream.filter(&(byte_size(&1) > 0))
  |> Stream.map(&String.split(&1, " ", trim: true))
  |> Enum.reduce({[], []}, fn row, {l, r} ->
    {[String.to_integer(Enum.at(row, 0)) | l], [String.to_integer(Enum.at(row, 1)) | r]}
  end)

# ------------------------First subtask------------------------------

first_solution =
  Enum.zip(Enum.sort(left), Enum.sort(right))
  |> Enum.map(fn row ->
    Kernel.abs(Kernel.elem(row, 0) - Kernel.elem(row, 1))
  end)
  |> Enum.sum()

IO.puts("First solution: #{first_solution}")

# ------------------------Second subtask------------------------------

frequencies = Enum.frequencies(right)

second_solution =
  left
  |> Enum.map(fn value ->
    Map.get(frequencies, value, 0) * value
  end)
  |> Enum.sum()

IO.puts("Second solution: #{second_solution}")
