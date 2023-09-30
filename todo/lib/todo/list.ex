defmodule Todo.List do

  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %Todo.List{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %Todo.List{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do

      :error -> todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %Todo.List{todo_list | entries: new_entries}
    end
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def delete_entry(todo_list, entry_id) do
    %Todo.List{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end

end

defmodule Todo.List.CSV do

  def import(fname) do
    entries = File.stream!(fname)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(fn [d, t] -> [String.split(d, "/"), t] end)
      |> Stream.map(fn [d, t] -> [Enum.map(d, &String.to_integer/1), t] end)
      |> Stream.map(fn [[y,d,m], t] -> %{date: Date.new(y,d,m) |> elem(1), title: t} end)

    Todo.List.new(entries)
  end

end
