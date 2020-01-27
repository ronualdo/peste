defmodule PesteApiWeb.TelegramController do
  use PesteApiWeb, :controller

  @answers_mapping %{}

  def webhook(conn, %{"inline_query" => %{"id" => id, "query" => query}}) do
    query
    |> QueryEngine.run(@answers_mapping)
    |> render_results()
    |> return_response()
  end

  def webhook(conn, params) do
    conn
    |> json(%{success: true})
  end

  defp render_results(results) do
  end

  defp return_response(success) do
  end
end
