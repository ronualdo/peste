defmodule HttpGatewayTest do
  use ExUnit.Case

  setup do
    bypass = Bypass.open(port: 7812)
    {:ok, bypass: bypass}
  end

  describe "get/2" do
    test "returns response of a get request against provided url", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/my-test", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, ~S({"name": "john doe", "age": 25}))
      end)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.get("/my-test")

      assert {:ok, response_body} = response
      assert response_body == %{status: 200, body: %{"name" => "john doe", "age" => 25}}
    end

    test "returns an error if server requested is down", %{bypass: bypass} do
      Bypass.down(bypass)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.get("/my-test")

      assert {:error, :econnrefused} = response
    end

    test "returns an error response from the server requested", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/my-test", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(500, ~S({"message": "error message"}))
      end)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.get("/my-test")

      assert {:error, response_body} = response
      assert response_body == %{status: 500, body: %{"message" => "error message"}}
    end
  end

  describe "post/3" do
    test "returns response of a post request against provided url", %{bypass: bypass} do
      Bypass.expect_once(bypass, "POST", "/my-test", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(202, ~S({"name": "john doe", "age": 25}))
      end)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.post("/my-test", %{param1: "teste", param2: 25})

      assert {:ok, response_body} = response
      assert response_body == %{status: 202, body: %{"name" => "john doe", "age" => 25}}
    end

    test "returns an error if server requested is down", %{bypass: bypass} do
      Bypass.down(bypass)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.post("/my-test", %{test: "value"})

      assert {:error, :econnrefused} = response
    end

    test "returns an error response from the server requested", %{bypass: bypass} do
      Bypass.expect_once(bypass, "POST", "/my-test", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(500, ~S({"message": "error message"}))
      end)

      response =
        HttpGateway.config(base_url: "http://localhost:7812", enable_json_parse: true)
        |> HttpGateway.post("/my-test", %{test: "value"})

      assert {:error, response_body} = response
      assert response_body == %{status: 500, body: %{"message" => "error message"}}
    end
  end
end
