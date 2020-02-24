defmodule TelegramBotClient do
  alias TelegramBotClient.{Methods, Types}

  defdelegate input_text_message_content(text_message), to: Types

  defdelegate inline_query_result_article(message_content, id, title), to: Types

  defdelegate answer_inline_query(token, inline_query_id, inline_query_result, base_url),
    to: Methods
end
