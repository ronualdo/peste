defmodule PesteApiWeb.TelegramControllerTest do
  use PesteApiWeb.ConnCase

  setup do
    bypass = Bypass.open(port: 9012)
    {:ok, bypass: bypass}
  end

  describe "webhook/2" do
    test "it returns success if no query is found", %{conn: conn, bypass: bypass} do
      Bypass.stub(bypass, "POST", "/bot#{peste_bot_token()}/answerInlineQuery", fn conn -> 
        conn
        |> Plug.Conn.resp(200, ~s[{"body": {"success": true}}])
      end)

      response = 
        conn
        |> post("/v1/webhook", %{"inline_query" => %{"id" => 123456, "query" => "inexistent query"}})
        |> json_response(200)

      assert response == %{"success" => true}
    end

    test "returns success when query is found and successfuly processed", %{conn: conn, bypass: bypass} do
      Bypass.stub(bypass, "POST", "/bot#{peste_bot_token()}/answerInlineQuery", fn conn -> 
        conn
        |> Plug.Conn.resp(200, ~s[{"body": {"success": true}}])
      end)

      response = 
        conn
        |> post("/v1/webhook", %{"inline_query" => %{"id" => 123456, "query" => "cinema"}})
        |> json_response(200)

      assert response == %{"success" => true}
    end

    test "returns error message when request fails", %{conn: conn, bypass: bypass} do
      Bypass.down(bypass)

      response = 
        conn
        |> post("/v1/webhook", %{"inline_query" => %{"id" => 123456, "query" => "cinema"}})
        |> json_response(500)

      Bypass.up(bypass)

      assert response == %{"success" => false, "error" => "econnrefused"}
    end
  end

  defp peste_bot_token do
    Application.get_env(:peste_api, :peste_bot_token)
  end
end
