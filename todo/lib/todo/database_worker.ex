defmodule Todo.DatabaseWorker do
  use GenServer

  def start_link(db_folder) do
    IO.puts("Starting DB worker.")
    GenServer.start_link(__MODULE__, db_folder)
  end

  def store(pid, key, data) do
    GenServer.cast(pid, {:store, key, data})
  end

  def get(pid, key, caller) do
    GenServer.cast(pid, {:get, key, caller})
  end

  def init(db_folder) do
    File.mkdir_p!(db_folder)
    {:ok, %{db_folder: db_folder}}
  end

  def handle_cast({:store, key, data}, state) do
    key
    |> file_name(state.db_folder)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, state}
  end

  def handle_cast({:get, key, caller}, state) do
    data = case File.read(file_name(key, state.db_folder)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
    IO.inspect(data)
    GenServer.reply(caller, data)
    {:noreply, state}
  end

  defp file_name(key, dir) do
    Path.join(dir, to_string(key))
  end

end
