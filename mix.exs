defmodule FacebookSignedRequest.Mixfile do
  use Mix.Project

  def project do
    [
      app: :facebook_signed_request,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"}
    ]
  end

  defp description do
    """
    Elixir library for validating and parsing signed requests from Facebook.
    """
  end

   defp package do
    [
      licenses: ["MIT"],
      keywords: ["Elixir", "Facebook", "Signed Request", "Facebook SDK"],
      maintainers: ["Gerald Urschitz"]
    ]
  end
end
