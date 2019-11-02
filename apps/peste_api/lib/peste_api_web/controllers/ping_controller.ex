defmodule PesteApiWeb.PingController do
  use PesteApiWeb, :controller

  def ping(conn, _params) do
    json(conn, %{ping: true})
  end

  def update(conn, %{"inline_query" => %{"id" => inline_query_id, "query" => "cinema"}}) do
    TelegramBotClient.answer_inline_query(
      peste_bot_token(),
      inline_query_id,
      movies_inline_query_answer()
    )

    conn
    |> json(%{ok: true, result: true})
  end

  def update(conn, _params) do
    conn
    |> json(%{success: true})
  end

  defp movies_inline_query_answer() do
    message_content = TelegramBotClient.input_text_message_content("Em breve: Horario de cinemas")
    message_id = "1"
    title = "Horário dos cinemas"

    inline_query_result =
      TelegramBotClient.inline_query_result_article(message_id, title, message_content)

    [inline_query_result]
  end

  defp peste_bot_token(), do: System.get_env("PESTE_BOT_TOKEN")
end
