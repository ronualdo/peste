defmodule PesteApiWeb.PesteView do

  alias Peste.Movie

  def format(nil), do: ""

  def format(%Movie{sessions: sessions, title: title}) do
    sessions
    |> Enum.group_by(fn session -> session.type end)
    |> Enum.map(fn {type, sessions} -> %{type: type, start_times: merge_start_times(sessions)} end)
    |> Enum.map(fn session -> "#{title} #{session.type} [#{parse_start_times(session.start_times)}]" end)
    |> Enum.join(~s(\n))
  end

  def merge_start_times(sessions) do
    sessions
    |> Enum.reduce([], fn session, acc -> acc ++ session.start_times end)
  end

  def parse_start_times(start_times), do: Enum.join(start_times, ", ")
end
