defmodule Peste.Moviecom do
  alias Peste.{Movie, Session}

  def get_sessions_endpoint(nil), do: raise(ArgumentError, "invalid date value provided: nil")

  def get_sessions_endpoint(date) do
    "https://www.veloxtickets.com/Parceiro/P-Moviecom/AjaxService/LocalDetail/ServiceGetSessions?date=#{
      date
    }&localCode=MNT&cityCode=natal"
  end

  def parse_movies_data({:error, _} = error), do: error

  def parse_movies_data({:ok, data}) do
    data.body
    |> sanitize_body()
    |> Jason.decode!()
    |> Enum.map(&parse_event/1)
  end

  defp sanitize_body(body) do
    body
    |> String.replace("\\", "")
    |> String.replace("\"[", "[")
    |> String.replace("]\"", "]")
  end

  defp parse_event(%{"event" => %{"eventTitle" => event_title}, "rooms" => rooms_data}) do
    %Movie{
      title: event_title,
      sessions: Enum.map(rooms_data, &parse_room/1)
    }
  end

  defp parse_room(%{"filters" => filters, "schedules" => schedules}) do
    %Session{
      type: Enum.reduce(filters, "", &reduce_to_types/2),
      start_times: Enum.map(schedules, fn %{"startTime" => start_time} -> start_time end)
    }
  end

  def reduce_to_types(%{"fCod" => code}, acc) do
    cond do
      code in ["Dublado", "Legendado", "3D"] ->
        (acc <> " " <> code)
        |> String.trim()

      true ->
        acc
    end
  end
end
