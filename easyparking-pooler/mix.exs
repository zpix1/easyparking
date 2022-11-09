defmodule Pooler.MixProject do
  use Mix.Project

  def project do
    [
      app: :pooler,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        dialyzer: :prod,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Pooler.Application, []},
      extra_applications: [:logger, :runtime_tools, :memento]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # static code analysis - code consistency
      {:credo, "~> 1.6", only: :dev, runtime: false},
      # static code analysis - types
      {:dialyxir, "~> 1.0", only: :prod, runtime: false},
      # docs generation
      {:ex_doc, "~> 0.28.4", only: :dev, runtime: false},
      # test coverage
      {:excoveralls, "~> 0.14.6", only: :test},
      # documentation checks
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      # Database
      {:memento, "~> 0.3.2"},
      # REST API Documentation
      {:open_api_spex, "~> 3.14"},
      {:phoenix, "~> 1.6.12"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      # Auth
      {:pow, "~> 1.0.27"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
