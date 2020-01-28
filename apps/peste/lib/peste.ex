defmodule Peste do
  alias Peste.Moviecom

  def retrieve_movies_schedule(date, get_function \\ &tesla_get_function/1) do
    date
    |> Moviecom.get_sessions_endpoint()
    |> get_function.()
    |> Moviecom.parse_movies_data()
  end

  defp tesla_get_function(url) do
    HttpGateway.config()
    |> HttpGateway.get(url)
  end
end
