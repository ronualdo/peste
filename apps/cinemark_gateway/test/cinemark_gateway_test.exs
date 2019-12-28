defmodule CinemarkGatewayTest do
  use ExUnit.Case
  doctest CinemarkGateway

  test "greets the world" do
    assert CinemarkGateway.hello() == :world
  end
end
