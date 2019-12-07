defmodule MoviecomGateway do
  alias MoviecomGateway.{Parser, MovieSchedule, ServiceClient}

  def retrieve_schedule(date) do
    date
    |> ServiceClient.get_sessions()
    |> parse_movie_schedule()
    |> wrap_result()
  end

  defp parse_movie_schedule({:ok, sessions}) do
    sessions
    |> Enum.map(&Parser.extract_movie_schedule/1)
  end

  defp parse_movie_schedule({:error, _reason} = error), do: error

  defp wrap_result(movie_schedule), do: {:ok, movie_schedule}

  defp wrap_result({:error, _reason} = error), do: error
end
