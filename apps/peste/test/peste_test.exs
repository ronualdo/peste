defmodule PesteTest do
  use ExUnit.Case
  doctest Peste

  test "greets the world" do
    assert Peste.hello() == :world
  end
end
