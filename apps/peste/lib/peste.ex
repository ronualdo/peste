defmodule Peste do
  def movies_schedule(:all, request_schedule_fn \\ &MoviecomGateway.retrieve_schedule/1) do
    %{
      moviecom: retrieve_moviecom_schedule(request_schedule_fn)
    }
  end

  defp retrieve_moviecom_schedule(request_schedule_fn) do
    today()
    |> request_schedule_fn.()
    |> unwrap_schedule()
  end

  defp today() do
    "America/Recife"
    |> Timex.now()
    |> Timex.to_date()
  end

  defp unwrap_schedule({:ok, schedule}), do: schedule
  defp unwrap_schedule({:error, _reason} = error), do: error
end
