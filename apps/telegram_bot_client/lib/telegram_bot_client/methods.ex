defmodule TelegramBotClient.Methods do
  def answer_inline_query(token, inline_query_id, results, opts \\ []) do
    api = opts[:using]
    api.post(token, "teste", %{})
    :ok
  end
end
