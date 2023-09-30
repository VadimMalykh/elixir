defmodule TodoCacheTest do
  use ExUnit.Case

  test "server_process" do
    {:ok, cache} = Todo.Cache.start()
    bob_pid = Todo.Cache.server_process(cache, "bob")

    assert bob_pid != Todo.Cache.server_process(cache, "alice")
    assert bob_pid == Todo.Cache.server_process(cache, "bob")
  end

  test "todo operations" do
    {:ok, cache} = Todo.Cache.start()
    alice = Todo.Cache.server_process(cache, "alice")
    Todo.Server.add_entry(alice, %{date: ~D[2022-06-20], title: "Dantist"})
    entries20 = Todo.Server.entries(alice, ~D[2022-06-20])
    entries22 = Todo.Server.entries(alice, ~D[2022-06-22])

    assert [%{date: ~D[2022-06-20], title: "Dantist"}] = entries20
    assert [] = entries22
  end

end
