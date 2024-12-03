# ---------------------------Common----------------------------------

data =
  File.stream!("input.txt", :line)
  |> Stream.map(&String.trim/1)
  |> Stream.filter(&(byte_size(&1) > 0))
  |> Stream.map(&String.split(&1, " ", trim: true))
  |> Stream.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  |> Enum.to_list()

# ------------------------First subtask------------------------------

defmodule FirstSubtask do
  def is_safe(list) do
    if !(list != Enum.sort(list) && list != Enum.sort(list, :desc)) do
      list_offset = List.delete_at(list, 0)

      elements_out_of_bound =
        Enum.zip(list, list_offset)
        |> Enum.map(fn pair ->
          difference_in_pair = Kernel.abs(Kernel.elem(pair, 0) - Kernel.elem(pair, 1))

          if 1 > difference_in_pair || difference_in_pair > 3 do
            1
          else
            0
          end
        end)
        |> Enum.sum()

      if elements_out_of_bound != 0 do
        false
      else
        true
      end
    else
      false
    end
  end
end

first_solution =
  data
  |> Enum.filter(&FirstSubtask.is_safe/1)
  |> Enum.count()

IO.puts("result: #{first_solution}")

# ------------------------Second subtask------------------------------

defmodule SecondSubtask do
  def is_safe(list) do
    if !FirstSubtask.is_safe(list) do
      number_of_invalid_combinations =
        list
        |> Enum.with_index()
        |> Enum.map(fn {_value, index} ->
          if FirstSubtask.is_safe(List.delete_at(list, index)) do
            0
          else
            1
          end
        end)
        |> Enum.sum()

      if number_of_invalid_combinations != length(list) do
        true
      else
        false
      end
    else
      true
    end
  end
end

second_solution =
  data
  |> Enum.filter(&SecondSubtask.is_safe/1)
  |> Enum.count()

IO.puts("result: #{second_solution}")
