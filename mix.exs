defmodule RemoveUnused.MixProject do
  use Mix.Project

  @source_url ""

  def project do
    [
      app: :remove_unused,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
      source_url: @source_url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      description: "Remove unused aliases and imports",
      maintainers: ["Krister Viirsaar"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp docs do
    [
      extras: [
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
