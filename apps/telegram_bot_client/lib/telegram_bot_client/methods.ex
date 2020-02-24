defmodule TelegramBotClient.Methods do
  alias TelegramBotClient.UrlParser

  @http_gateway_base_config %{enable_json_parse: true}

  def answer_inline_query(token, inline_query_id, results, base_url \\ "https://api.telegram.org") do
    token
    |> build_url("answerInlineQuery")
    |> post_request(base_url, %{
      inline_query_id: inline_query_id,
      results: results
    })
  end

  defp build_url(token, action) do
    "bot#{token}/#{action}"
  end

  defp post_request(resource, base_url, parameters) do
    @http_gateway_base_config
    |> Map.put(:base_url, base_url)
    |> HttpGateway.config()
    |> HttpGateway.post(resource, parameters)
  end
end
