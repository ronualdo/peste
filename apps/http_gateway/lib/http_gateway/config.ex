defmodule HttpGateway.Config do
  defstruct middlewares: [], http_adapter: {}

  def init(opts) do
    middlewares =
      opts
      |> Enum.reduce([], fn opt, acc -> [process_opt(opt) | acc] end)

    %__MODULE__{
      middlewares: middlewares,
      http_adapter: {Tesla.Adapter.Hackney, [recv_timeout: 30_000]}
    }
  end

  def process_opt({:base_url, base_url}) do
    {Tesla.Middleware.BaseUrl, base_url}
  end

  def process_opt({:enable_json_parse, true}) do
    Tesla.Middleware.JSON
  end
end
