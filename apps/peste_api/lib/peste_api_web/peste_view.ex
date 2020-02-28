defmodule PesteApiWeb.PesteView do

  alias Peste.Movie

  def format(nil), do: ""

  def format(%Movie{sessions: sessions, title: title}) do
    sessions
    |> Enum.group_by(&session_type/1)
    |> Enum.map(&merge_sessions_by_type/1)
    |> Enum.map(fn session -> format_session(session, title) end)
    |> Enum.join(~s(\n))
  end

  defp session_type(session), do: session.type

  defp merge_sessions_by_type({type, sessions}) do
    %{type: type, start_times: merge_start_times(sessions)}
  end

  defp merge_start_times(sessions) do
    sessions
    |> Enum.reduce([], fn session, acc -> acc ++ session.start_times end)
  end

  defp format_session(%{type: type, start_times: start_times}, movie_title) do
    "#{movie_title} #{type} [#{parse_start_times(start_times)}]"
  end

  def parse_start_times(start_times), do: Enum.join(start_times, ", ")
end
