defmodule Todo.Server do

  use GenServer

  def start_link(list_name) do
    GenServer.start_link(Todo.Server, list_name)
  end

  def add_entry(pid, entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  def init(list_name), do: {:ok, {list_name, Todo.Database.get(list_name) || Todo.List.new()}}

  def handle_call({:entries, date}, _, state = {_, todo_list}) do
    IO.inspect("#{inspect(self())}: state - #{inspect(state)}")
    {:reply, Todo.List.entries(todo_list, date), state}
  end

  def handle_cast({:add_entry, entry}, {list_name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, entry)
    Todo.Database.store(list_name, new_list)
    {:noreply, {list_name, new_list}}
  end

end
