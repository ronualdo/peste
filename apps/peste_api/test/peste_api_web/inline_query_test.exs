defmodule PesteApiWeb.InlineQueryTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.InlineQuery

  describe "queries/0" do
    test "returns available queries" do
      result = InlineQuery.queries()

      assert %{movies: %InlineQuery{}} = result
    end
  end

  describe "filter_query/2" do
    test "returns inline query with its id when it exists" do
      result = 
        InlineQuery.queries()
        |> InlineQuery.filter_query(:movies)

      assert [movies: %InlineQuery{title: "Horário dos Cinemas", result_fn: _function}] = result
    end

    test "returns an empty list if query does not exists" do
      result = 
        InlineQuery.queries()
        |> InlineQuery.filter_query(:not_found_query)

      assert [] == result
    end
  end
end
