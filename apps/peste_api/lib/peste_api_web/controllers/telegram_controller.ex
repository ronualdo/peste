defmodule PesteApiWeb.TelegramController do
  use PesteApiWeb, :controller

  alias PesteApiWeb.{QueryEngine, TelegramMessages}

  def webhook(conn, %{"inline_query" => %{"id" => id, "query" => query}}) do
    query
    |> QueryEngine.run(my_mapping())
    |> render_results(id)
    |> return_response(conn)
  end

  def webhook(conn, params) do
    conn
    |> json(%{success: true})
  end

  defp render_results(results, inline_query_id) do
    my_answer = 
      results
      |> Enum.map(&parse_to_bot_client/1)


    TelegramBotClient.answer_inline_query(peste_bot_token(), inline_query_id, my_answer)
  end

  defp parse_to_bot_client(query_result) do
    input_message_content = 
      query_result.answer
      |> TelegramBotClient.input_text_message_content()

    TelegramBotClient.inline_query_result_article(query_result.id, query_result.title, input_message_content)
  end

  defp return_response(success, conn) do
    json(conn, %{success: true})
  end

  defp peste_bot_token do
    Application.fetch_env!(:peste_api, :peste_bot_token)
  end

  defp my_mapping do
    %{movies: &TelegramMessages.movies_message/0}
  end
end
