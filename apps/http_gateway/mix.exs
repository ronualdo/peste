defmodule HttpGateway.MixProject do
  use Mix.Project

  def project do
    [
      app: :http_gateway,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:bypass, "~> 1.0", only: :test},
      {:tesla, "~> 1.2.0"},
      {:jason, ">= 1.0.0"},
      {:hackney, "~> 1.10"}
    ]
  end
end
