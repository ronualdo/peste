defmodule TelegramBotClientTest do
  use ExUnit.Case
  doctest TelegramBotClient

  test "greets the world" do
    assert TelegramBotClient.hello() == :world
  end
end
