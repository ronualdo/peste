defmodule TelegramBotClient do
  alias TelegramBotClient.{TelegramApi, Types}

  defdelegate input_text_message_content(text_message), to: Types

  defdelegate inline_query_result_article(id, title, message_content), to: Types

  def answer_inline_query(token, inline_query_id, inline_query_result) do
    TelegramApi.post(token, "answerInlineQuery", %{
      inline_query_id: inline_query_id,
      results: inline_query_result
    })
  end
end
