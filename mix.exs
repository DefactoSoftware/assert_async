defmodule AssertAsync.MixProject do
  use Mix.Project

  @source_url "https://github.com/defactosoftware/assert_async"

  def project do
    [
      app: :assert_async,
      deps: deps(),
      description: description(),
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      source: @source_url,
      start_permanent: Mix.env() == :test,
      version: "0.0.1"
    ]
  end

  def description do
    """
    A module to easily test if async tasks have changed a state
    """
  end

  defp package do
    [
      name: :assert_async,
      maintainers: ["Marcel Horlings", "Maarten Jacobs"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url, "Docs" => "http://hexdocs.pm/assert_async/"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
