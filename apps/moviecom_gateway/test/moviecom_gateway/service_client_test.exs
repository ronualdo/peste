defmodule MoviecomGateway.ServiceClientTest do
  use ExUnit.Case, async: true
  use Timex

  alias MoviecomGateway.ServiceClient

  describe "get_sessions/1" do
    test "returns list of sessions for that day" do
      response = ServiceClient.get_sessions(today())

      assert {:ok, sessions} = response
    end
  end

  defp today() do
    "America/Recife"
    |> Timex.now()
    |> Timex.to_date()
  end
end
