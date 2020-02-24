defmodule PesteApiWeb.InlineQuery do
  alias PesteApiWeb.InlineQuery.MoviesResult

  defstruct title: "Default Inline Query", result_fn: &__MODULE__.default_result_fn/0

  defp default_result_fn do
    raise "Unsupported Inline Query [Default Inline Query]"
  end

  def queries do
    %{
      movies: %__MODULE__{
        title: "Horário dos Cinemas",
        result_fn: &MoviesResult.call/0
      }
    }
  end

  def filter_query(queries, key) do
    queries
    |> Enum.filter(by_query_key(key))
  end

  defp by_query_key(key), do: fn {query_key, _value} -> key == query_key end
end
