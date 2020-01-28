defmodule Peste.MoviecomTest do
  use ExUnit.Case, async: true

  alias Peste.{Movie, Moviecom, Session}

  describe "get_sessions_endpoint/1" do
    test "returns sessions endpoint for specified date" do
      date = ~D[2019-02-12]

      endpoint = Moviecom.get_sessions_endpoint(date)

      assert endpoint ==
               "https://www.veloxtickets.com/Parceiro/P-Moviecom/AjaxService/LocalDetail/ServiceGetSessions?date=2019-02-12&localCode=MNT&cityCode=natal"
    end

    test "raises an error if provided date is nil" do
      assert_raise ArgumentError, fn -> Moviecom.get_sessions_endpoint(nil) end
    end
  end

  describe "parse_movies_data/1" do
    test "returns data error when it is provided to the function" do
      data_error = {:error, "error data"}

      result = Moviecom.parse_movies_data(data_error)

      assert result == data_error
    end

    test "parses movie data provided" do
      data = ~s([
        {
          "event": {"eventTitle": "star wars"},
          "rooms": [
            {
              "filters": [
                {"fCapt": "Dublado", "fCod": "Dublado"},
                {"fCapt": "3D", "fCod": "3D"}
              ],
              "schedules": [{"startTime": "12:35"}]
            }
          ]
        },
        {
          "event": {"eventTitle": "matrix"},
          "rooms": [
            {
              "filters": [{"fCapt": "Dublado", "fCod": "Dublado"}],
              "schedules": [{"startTime": "12:35"}, {"startTime": "17:32"}]
            }
          ]
        }
      ])

      result = Moviecom.parse_movies_data({:ok, %{body: data, status: 200}})

      assert result == [
               %Movie{
                 title: "star wars",
                 sessions: [
                   %Session{type: "Dublado 3D", start_times: ["12:35"]}
                 ]
               },
               %Movie{
                 title: "matrix",
                 sessions: [
                   %Session{type: "Dublado", start_times: ["12:35", "17:32"]}
                 ]
               }
             ]
    end
  end
end
