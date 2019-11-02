defmodule TelegramBotClient.MethodsTest do
  use ExUnit.Case, async: true

  import Mox

  alias TelegramBotClient.{ApiMock, Methods}

  setup :verify_on_exit!

  describe "answer_inline_query/4" do
    test "returns ok when api call is processed with success" do
      ApiMock
      |> expect(:post, fn token, url, parameters -> {:ok, %{}} end)

      assert Methods.answer_inline_query("token", "1", [], using: ApiMock) == :ok
    end
  end
end
