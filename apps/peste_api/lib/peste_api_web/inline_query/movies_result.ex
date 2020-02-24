defmodule PesteApiWeb.InlineQuery.MoviesResult do

  alias PesteApiWeb.{Calendar, PesteView}

  def call do
    Calendar.date_now()
    |> Peste.retrieve_movies_schedule()
    |> Enum.reduce("", fn movie, acc -> "#{PesteView.format(movie)}\n#{acc}" end)
  end
end
