defmodule PesteApiWeb.PingController do
  use PesteApiWeb, :controller

  def ping(conn, _params) do
    json(conn, %{ping: true})
  end

  def update(conn, %{"inline_query" => %{"id" => id, "query" => "cinema"}}) do
    TelegramClient.answer_inline_query(id)
    conn
    |> json(%{success: true})
  end

  def update(conn, params) do
    conn
    |> json(%{success: true})
  end
end
