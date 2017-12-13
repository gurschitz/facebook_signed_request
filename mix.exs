defmodule FacebookSignedRequest.Mixfile do
  use Mix.Project

  def project do
    [
      app: :facebook_signed_request,
      version: "0.1.1",
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
      {:poison, "~> 3.1"},
      {:ex_doc, ">= 0.0.0", only: :dev}
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
      maintainers: ["Gerald Urschitz"],
      links: %{"GitHub" => "https://github.com/gurschitz/facebook_signed_request"}
    ]
  end
end
