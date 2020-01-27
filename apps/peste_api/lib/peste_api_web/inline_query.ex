defmodule PesteApiWeb.InlineQuery do
  @results_messages_mapping %{
    movies: fn -> "teste" end
  }

  def run(query, _content_mapping \\ @default_content_mapping)

  def run("cinema", content_mapping) do
    movie_content_function = content_mapping[:movies]

    [
      %{id: :cinema, title: "Horário dos Cinemas", content: movie_content_function.()}
    ]
  end

  def run(_, _content_mapping), do: []
end
