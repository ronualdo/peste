defmodule PesteApiWeb.PesteViewTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.PesteView
  alias Peste.Movie

  describe "format/1" do
    test "returns movie's string representation" do
      movie = %Movie{
        title: "test movie",
        sessions: [
          %{type: "Legendado", start_times: ["14:23", "21:45"]},
          %{type: "Dublado 3D", start_times: ["14:23", "21:45", "23:40"]}
        ]
      } 

      result = PesteView.format(movie)

      assert result == ~s(test movie Legendado [14:23, 21:45]\ntest movie Dublado 3D [14:23, 21:45, 23:40])
    end

    test "returns an empty string for nil parameters" do
      result = PesteView.format(nil)

      assert result == ""
    end
  end
end
