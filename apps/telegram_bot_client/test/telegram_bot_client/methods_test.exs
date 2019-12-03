defmodule TelegramBotClient.MethodsTest do
  use ExUnit.Case, async: true

  import Mox

  alias TelegramBotClient.{ApiMock, Methods}

  setup :verify_on_exit!

  describe "answer_inline_query/4" do
    test "returns ok when api call is processed with success" do
      ApiMock
      |> stub(:client, fn _url, _token -> %{} end)
      |> expect(:post, fn _token, _url, _parameters -> {:ok, true} end)

      assert {:ok, true} = Methods.answer_inline_query("token", "1", [], using: ApiMock)
    end
  end
end
