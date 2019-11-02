defmodule TelegramBotClient.TelegramApi do
  @behaviour TelegramBotClient.Api

  alias Tesla.Env

  def post(token, method, parameters) do
    with url <- endpoint(token, method) do
      middleware()
      |> Tesla.post(url, parameters)
      |> wrap_result()
    end
  end

  defp endpoint(token, method), do: "bot#{token}/#{method}"

  defp middleware() do
    [
      {Tesla.Middleware.BaseUrl, "https://api.telegram.org"},
      Tesla.Middleware.JSON
    ]
    |> Tesla.client()
  end

  defp wrap_result({:ok, %Env{status: status, body: %{"ok" => true, "result" => result}}})
       when status == 200 do
    {:ok, result}
  end

  defp wrap_result({:ok, %Env{body: %{"description" => description, "ok" => false}}}) do
    {:error, description}
  end
end
