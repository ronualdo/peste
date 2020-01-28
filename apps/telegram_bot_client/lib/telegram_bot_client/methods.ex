defmodule TelegramBotClient.Methods do
  alias TelegramBotClient.UrlParser

  @http_gateway_config HttpGateway.config(
                         base_url: "https://api.telegram.org",
                         enable_json_parse: true
                       )

  def answer_inline_query(token, inline_query_id, results) do
    token
    |> build_url("answerInlineQuery")
    |> post_request(%{
      inline_query_id: inline_query_id,
      results: results
    })
  end

  defp build_url(token, action) do
    "bot#{token}/#{action}"
  end

  def post_request(resource, parameters) do
    HttpGateway.post(@http_gateway_config, resource, parameters)
  end
end
