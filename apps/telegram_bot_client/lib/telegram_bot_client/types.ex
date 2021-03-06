defmodule TelegramBotClient.Types do
  def input_text_message_content(message) do
    %{message_text: message}
  end

  def inline_query_result_article(input_message_content, id, title) do
    %{type: "article", id: id, title: title, input_message_content: input_message_content}
  end
end
