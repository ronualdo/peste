defmodule PesteApiWeb.QueryEngineTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.QueryEngine
  alias PesteApiWeb.QueryEngine.Query

  describe "build_query/1" do
    test "builds a query with input provided" do
      cinema_query = QueryEngine.build_query("cinema")

      assert cinema_query == %Query{input: "cinema", result: nil}
    end
  end

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
