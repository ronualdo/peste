defmodule TelegramBotClient.TelegramApi do
  @behaviour TelegramBotClient.Api

  alias Tesla.Env

  def post(client, method, parameters) do
    with url <- endpoint(client.token, method) do
      client.middlewares
      |> Tesla.client()
      |> Tesla.post(url, parameters)
      |> wrap_result()
    end
  end

  def client(url, token) do
    %{
      token: token,
      middlewares: [
        Tesla.Middleware.JSON,
        {Tesla.Middleware.BaseUrl, url}
      ]
    }
  end

  defp endpoint(token, method), do: "bot#{token}/#{method}"

  defp wrap_result({:ok, %Env{status: status, body: %{"ok" => true, "result" => result}}})
       when status == 200 do
    {:ok, result}
  end

  defp wrap_result({:ok, %Env{body: %{"description" => description}}}) do
    {:error, description}
  end

  defp wrap_result({:ok, %Env{status: 500, method: method, url: url}}),
    do: {:error, "#{method} #{url} returned 500"}

  defp wrap_result({:error, _reason} = error), do: error
end
