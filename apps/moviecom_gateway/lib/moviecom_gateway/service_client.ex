defmodule MoviecomGateway.ServiceClient do
  alias Tesla.Env

  #   # https://www.veloxtickets.com/Parceiro/P-Moviecom/AjaxService/LocalDetail/ServiceGetSessions?date=2019-12-07&localCode=MNT&cityCode=natal

  def get_sessions(date) do
    with endpoint <- build_endpoint(date) do
      client()
      |> Tesla.client()
      |> Tesla.get(endpoint)
      |> wrap_result()
    end
  end

  defp build_endpoint(date) do
    "ServiceGetSessions?date=#{date}&localCode=MNT&cityCode=natal"
  end

  defp client() do
    [
      {Tesla.Middleware.BaseUrl,
       "https://www.veloxtickets.com/Parceiro/P-Moviecom/AjaxService/LocalDetail"},
      Tesla.Middleware.JSON
    ]
  end

  defp wrap_result({:ok, %Env{status: status, body: body}})
       when status == 200 do
    {:ok, Jason.decode!(body)}
  end

  defp wrap_result({:ok, %Env{body: %{"description" => description}}}) do
    {:error, description}
  end

  defp wrap_result({:ok, %Env{status: 500, method: method, url: url}}),
    do: {:error, "#{method} #{url} returned 500"}

  defp wrap_result({:error, _reason} = error), do: error
end
