defmodule PesteApiWeb.QueryEngineTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.QueryEngine

  describe "run/1" do
    test "returns cinema query result" do
      query_answers_mapping = %{
        movies: fn -> "test answer" end
      }
      expected_results = [
        %{id: :movies, title: "Horário dos Cinemas", answer: "test answer"}
      ]


      results = QueryEngine.run("cinema", query_answers_mapping)

      assert results == expected_results
    end

    test "returns empty results for invalid query" do
      query_answers_mapping = %{
        movies: fn -> "test answer" end
      }
      expected_results = []


      results = QueryEngine.run("cinem", query_answers_mapping)

      assert results == expected_results
    end
  end
end
