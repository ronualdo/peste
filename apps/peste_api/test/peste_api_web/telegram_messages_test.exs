defmodule PesteApiWeb.TelegramMessagesTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.TelegramMessages
  alias Peste.{Movie, Session}

  describe "parse_movie/1" do
    test "returns movie's string representation" do
      movie = %Movie{
        title: "test movie",
        sessions: [
          %{type: "Legendado", start_time: ["14:23", "21:45"]},
          %{type: "Dublado 3D", start_time: ["14:23", "21:45", "23:40"]}
        ]
      } 

      result = TelegramMessages.parse_movie(movie)

      assert result == "test movie Legendado [14:23, 21:45]\\ntest movie Dublado 3D [14:23, 21:45, 23:40]"
    end
  end
end
