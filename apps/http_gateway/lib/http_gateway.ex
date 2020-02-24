defmodule HttpGateway do
  alias HttpGateway.Config

  def config(opts \\ []), do: Config.init(opts)

  def get(%Config{middlewares: middlewares, http_adapter: http_adapter}, url) do
    middlewares
    |> Tesla.client(http_adapter)
    |> Tesla.get(url)
    |> wrap_result()
  end

  def post(%Config{middlewares: middlewares, http_adapter: http_adapter}, url, params) do
    middlewares
    |> Tesla.client(http_adapter)
    |> Tesla.post(url, params)
    |> wrap_result()
  end

  defp wrap_result({:ok, %Tesla.Env{status: status} = result})
       when status >= 200 and status < 300 do
    {:ok, %{status: result.status, body: result.body}}
  end

  defp wrap_result({:ok, %Tesla.Env{} = result}) do
    {:error, %{status: result.status, body: result.body}}
  end

  defp wrap_result({:error, _reason} = error), do: error
end
