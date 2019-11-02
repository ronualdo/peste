defmodule TelegramBotClient.TypesTest do
  use ExUnit.Case, async: true

  alias TelegramBotClient.Types

  describe "input_text_message_content/2" do
    test "returns a text message content" do
      content = Types.input_text_message_content("my text message")

      assert %{message_text: "my text message"} == content
    end
  end

  describe "inline_query_result_article/4" do
    test "returns inline query result article" do
      inline_query_result = Types.inline_query_result_article("1", "test title", %{})

      assert %{type: "article", id: "1", title: "test title", input_message_content: %{}} =
               inline_query_result
    end
  end
end
