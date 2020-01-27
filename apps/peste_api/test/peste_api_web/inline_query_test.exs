defmodule PesteApiWeb.InlineQueryTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.InlineQuery

  describe "run/1" do
    test "returns movies query answer" do
      content_mapping = %{
        movies: fn -> "test content" end
      }
      
      movies_query_answer = InlineQuery.run("cinema", content_mapping)

      assert [%{id: :cinema, title: "Horário dos Cinemas", content: "test content"}] = movies_query_answer
    end

    test "returns an empty array when query has no answer" do
      content_mapping = %{
        movies: fn -> "test content" end
      }
      
      movies_query_answer = InlineQuery.run("non_existent", content_mapping)

      assert [] = movies_query_answer
    end
  end
end
