defmodule TelegramBotClient.TelegramApiTest do
  use ExUnit.Case, async: true

  alias TelegramBotClient.TelegramApi

  setup do
    chat_id = System.get_env("TEST_CHAT_ID")
    test_token = System.get_env("TEST_TOKEN")
    invalid_token = "invalid_#{test_token}"

    {:ok, chat_id: chat_id, test_token: test_token, invalid_token: invalid_token}
  end

  describe "post/3" do
    test "returns success when request is processed", %{chat_id: chat_id, test_token: test_token} do
      parameters = %{chat_id: chat_id, text: "test message"}

      result =
        TelegramApi.client("https://api.telegram.org", test_token)
        |> TelegramApi.post("sendMessage", parameters)

      assert {:ok,
              %{
                "message_id" => _message_id,
                "date" => _date,
                "text" => "test message",
                "chat" => chat,
                "from" => from
              }} = result

      assert %{"id" => _id, "type" => "private"} = chat

      assert %{
               "id" => _id,
               "first_name" => _first_name,
               "username" => _username,
               "is_bot" => true
             } = from
    end

    test "returns error when request fails", %{chat_id: chat_id, invalid_token: invalid_token} do
      parameters = %{chat_id: chat_id, text: "test message"}

      result =
        TelegramApi.client("https://api.telegram.org", invalid_token)
        |> TelegramApi.post("sendMessage", parameters)

      assert {:error, "Not Found"} = result
    end
  end
end
