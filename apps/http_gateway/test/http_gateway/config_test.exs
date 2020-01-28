defmodule HttpGateway.ConfigTest do
  use ExUnit.Case, async: true

  alias HttpGateway.Config

  describe "init/1" do
    test "returns a config without middlwares if no options is passed" do
      config = Config.init([])

      assert %Config{middlewares: []} = config
    end

    test "returns config with base url middlware for base_url opt" do
      config = Config.init(base_url: "http://test.com")

      assert %Config{middlewares: [{Tesla.Middleware.BaseUrl, "http://test.com"}]} = config
    end

    test "returns config with json middleware for enable_json_parse opt true" do
      config = Config.init(enable_json_parse: true)

      assert %Config{middlewares: [Tesla.Middleware.JSON]} = config
    end
  end
end
