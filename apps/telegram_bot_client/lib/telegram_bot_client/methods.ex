defmodule TelegramBotClient.Methods do
  alias TelegramBotClient.TelegramApi

  def answer_inline_query(token, inline_query_id, results, opts \\ [using: TelegramApi]) do
    api = opts[:using]

    telegram_api_url()
    |> api.client(token)
    |> api.post("answerInlineQuery", %{
      inline_query_id: inline_query_id,
      results: results
    })
  end

  def telegram_api_url do
    Application.get_env(:telegram_bot_client, :telegram_url, "https://api.telegram.org")
  end
end
