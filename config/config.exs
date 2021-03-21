use Mix.Config

config :resumex, port: String.to_integer(System.get_env("PORT") || "4000")
