defmodule PesteApiWeb.TelegramMessages do
  def movies_message do
    today()
    |> Peste.retrieve_movies_schedule()
    |> Enum.reduce("", fn movie, acc -> "#{parse_movie(movie)}\n#{acc}" end)
  end

  defp today do
    with {:ok, date_time} <- DateTime.now("America/Recife", Tzdata.TimeZoneDatabase) do
      DateTime.to_date(date_time)
    end
  end

  def parse_movie(movie) do
    movie.sessions
    |> Enum.map(fn session -> "#{movie.title} #{session.type} [#{parse_start_times(session.start_times)}]" end)
    |> Enum.join("\\n")
  end

  defp parse_start_times(start_times) do
    start_times
    |> Enum.join(", ")
  end
end
