defmodule PesteApiWeb.PesteView do

  alias Peste.Movie

  def format(nil), do: ""

  def format(%Movie{sessions: sessions, title: title}) do
    sessions
    |> Enum.map(fn session -> "#{title} #{session.type} [#{parse_start_times(session.start_times)}]" end)
    |> Enum.join(~s(\n))
  end

  def parse_start_times(start_times), do: Enum.join(start_times, ", ")
end
