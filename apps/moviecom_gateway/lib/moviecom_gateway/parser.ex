defmodule MoviecomGateway.Parser do
  alias MoviecomGateway.Movie

  def extract_movie_schedule(%{"event" => event, "rooms" => rooms}) do
    %Movie{
      title: event["eventTitle"],
      schedules: Enum.flat_map(rooms, &extract_schedule_from_room/1)
    }
  end

  defp extract_schedule_from_room(%{"schedules" => schedules}) do
    schedules
    |> Enum.map(&extract_time_from_schedule/1)
  end

  defp extract_time_from_schedule(%{"startTime" => start_time}) do
    start_time
  end
end
