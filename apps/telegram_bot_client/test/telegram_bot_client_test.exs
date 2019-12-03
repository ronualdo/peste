defmodule TelegramBotClientTest do
  use ExUnit.Case

  setup do
    bypass = Bypass.open(port: 1235)
    {:ok, bypass: bypass}
  end

  describe "answer_inline_query/3" do
    test "returns ok for a successful request", %{bypass: bypass} do
      Bypass.expect(
        bypass,
        "POST",
        "/botfaketoken/answerInlineQuery",
        fn conn ->
          conn
          |> Plug.Conn.put_resp_header("content-type", "application/json")
          |> Plug.Conn.resp(200, ~s<{"ok": true, "result": true}>)
        end
      )

      message_content = TelegramBotClient.input_text_message_content("test message")
      id = "1"
      title = "just another test"

      inline_query_result =
        TelegramBotClient.inline_query_result_article(id, title, message_content)

      assert {:ok, true} ==
               TelegramBotClient.answer_inline_query("faketoken", "123", [inline_query_result])
    end
  end
end
