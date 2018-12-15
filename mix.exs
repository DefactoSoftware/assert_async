defmodule AssertAsync.MixProject do
  use Mix.Project

  @source_url "https://github.com/defactosoftware/assert_async"
  def project do
    [
      app: :assert_async,
      deps: deps(),
      description: description(),
      elixir: "~> 1.7",
      package: package(),
      source: @source_url,
      build_embedded: Mix.env() == :test,
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
      name: :lti,
      maintainers: ["Marcel Horlings", "Maarten Jacobs"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url, "Docs" => "http://hexdocs.pm/test_selector/"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end
