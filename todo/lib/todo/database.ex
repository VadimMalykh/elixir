defmodule Todo.Database do
  use GenServer
  alias Todo.DatabaseWorker, as: Worker

  @db_folder "./persist"

  def start_link do
    IO.puts("Starting DB server.")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def init(_) do
    workers = 0..2
    |> Stream.map(&{&1, Worker.start_link(@db_folder)})
    |> Enum.map(fn {id, {:ok, pid}} -> {id, pid} end)
    |> Map.new
    |> IO.inspect()
    {:ok, %{workers: workers}}
  end

  def handle_cast({:store, key, data}, state) do
    choose_worker(key, state.workers) |> Worker.store(key, data)
    {:noreply, state}
  end

  def handle_call({:get, key}, caller, state) do
    choose_worker(key, state.workers)
    |> IO.inspect()
    |> Worker.get(key, caller)
    {:noreply, state}
  end

  def choose_worker(key, workers) do
    Map.get(workers, :erlang.phash2(key, 3))
  end
end
