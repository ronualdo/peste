defmodule MoviecomGatewayTest do
  use ExUnit.Case
  use Timex

  describe "retrieve_schedule/1" do
    test "returns list of movies scheduled for that day" do
      schedule = MoviecomGateway.retrieve_schedule(today())

      assert {:ok, _movies} = schedule
    end
  end

  defp today() do
    "America/Recife"
    |> Timex.now()
    |> Timex.to_date()
  end
end
