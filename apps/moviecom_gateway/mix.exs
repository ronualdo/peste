defmodule MoviecomGateway.MixProject do
  use Mix.Project

  def project do
    [
      app: :moviecom_gateway,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:timex],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 3.5"},
      {:tesla, "~> 1.2.0"},
      {:jason, ">= 1.0.0"}
    ]
  end
end
