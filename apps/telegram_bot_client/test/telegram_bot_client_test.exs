defmodule TelegramBotClientTest do
  use ExUnit.Case

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "answer_inline_query/3" do
    test "returns ok for a successful request", %{bypass: bypass} do
      Bypass.stub(bypass, "POST", "/answerInlineQuery", fn conn ->
        Plug.Conn.resp(conn, 200, "{ok: \"true\"}")
      end)

      message_content = TelegramBotClient.input_text_message_content("test message")
      id = "1"
      title = "just another test"

      inline_query_result =
        TelegramBotClient.inline_query_result_article(id, title, message_content)

      assert TelegramBotClient.answer_inline_query("bot_token", "123", [inline_query_result])
    end
  end
end
