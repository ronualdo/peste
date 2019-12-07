defmodule MoviecomGateway.ParserTest do
  use ExUnit.Case, async: true

  alias MoviecomGateway.{Movie, Parser}

  describe "extract_movie_schedule/1" do
    test "extract movie schedule from input" do
      event_input = %{
        "event" => %{
          "eventTitle" => "test movie"
        },
        "rooms" => [
          %{"schedules" => [%{"startTime" => "16:00"}]}
        ]
      }

      result = Parser.extract_movie_schedule(event_input)

      assert result == %Movie{title: "test movie", schedules: ["16:00"]}
    end
  end
end
