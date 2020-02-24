defmodule PesteApiWeb.TelegramController do
  use PesteApiWeb, :controller

  alias PesteApiWeb.InlineQuery

  def webhook(conn, %{"inline_query" => query}) do
    case process_query(query) do
      {:ok, _response} ->
        conn
        |> json(%{success: true})

      {:error, error} ->
        conn
        |> put_status(500)
        |> json(%{success: false, error: error})
    end
  end

  defp process_query(%{"id" => id, "query" => "cinema"}) do
    InlineQuery.queries()
    |> InlineQuery.filter_query(:movies)
    |> Enum.map(&build_movies_result/1)
    |> send_results(id)
  end

  defp process_query(_), do: {:ok, %{}}

  defp build_movies_result({id, %{title: title, result_fn: result_fn}}) do
    result_fn.()
    |> TelegramBotClient.input_text_message_content()
    |> TelegramBotClient.inline_query_result_article(id, title)
  end

  defp send_results(results, query_id) do
    peste_bot_token()
    |> TelegramBotClient.answer_inline_query(query_id, results, telegram_base_url())
  end

  defp peste_bot_token do
    Application.fetch_env!(:peste_api, :peste_bot_token)
  end

  defp telegram_base_url do
    Application.fetch_env!(:peste_api, :telegram_base_url)
  end
end
