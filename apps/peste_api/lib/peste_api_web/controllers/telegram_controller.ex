defmodule PesteApiWeb.TelegramController do
  use PesteApiWeb, :controller

  def webhook(conn, %{"inline_query" => %{"id" => id, "query" => query}}) do
    query
    |> InlineQuery.run()
    |> render_results()
  end

  def webhook(conn, params) do
    conn
    |> json(%{success: true})
  end

  def render_results(results) do

  end
end
