defmodule KeyValueStore do

  def start(), do: ServerProcess.start(KeyValueStore)

  def put(pid, key, value), do: ServerProcess.cast(pid, {:put, key, value})

  def get(pid, key), do: ServerProcess.call(pid, {:get, key})

  def init, do: %{}

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  def handle_call({:get, key}, state), do: {Map.get(state, key), state}
end
