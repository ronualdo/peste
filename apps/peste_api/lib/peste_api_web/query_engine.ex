defmodule PesteApiWeb.QueryEngine do
  def run(_query, _query_answers_mapping \\ %{})

  def run("cinema", query_answers_mapping) do
    answer_build_function = Map.fetch!(query_answers_mapping, :movies)
    [
      %{id: :movies, title: "Horário dos Cinemas", answer: answer_build_function.()}
    ]
  end

  def run(_query, query_answers_mapping), do: []
end
