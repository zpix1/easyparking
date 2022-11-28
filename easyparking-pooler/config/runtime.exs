import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/pooler start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :pooler, PoolerWeb.Endpoint, server: true
end

if config_env() == :dev do
  # amqp приложение само создает соединения и каналы и пытается восстановить их, если соединениe потеряно
  # https://hexdocs.pm/amqp/AMQP.Application.html
  config :amqp,
    connections: [
      default: [
        url: System.fetch_env!("RMQ_URL"),
        virtual_host: "/"
      ]
    ],
    channels: [
      # В него мы будем отправлять сообщения
      producer: [connection: :default]
    ]

  config :pooler,
    admin_email: System.get_env("POOLER_ADMIN_EMAIL", "admin"),
    admin_password: System.get_env("POOLER_ADMIN_PASSWORD", "admin")

  config :pooler, Pooler.Broadway,
    queue: System.fetch_env!("POOLER_QUEUE"),
    rmq_url: System.fetch_env!("RMQ_URL")

  config :pooler, Pooler.Clients.S3.Real,
    images_bucket: System.fetch_env!("IMAGES_BUCKET"),
    processed_images_bucket: System.fetch_env!("PROCESSED_IMAGES_BUCKET"),
    download_host: System.fetch_env!("DOWNLOAD_HOST"),
    download_port: System.fetch_env!("DOWNLOAD_PORT") |> String.to_integer()

  config :ex_aws,
    json_codec: Jason,
    access_key_id: System.fetch_env!("S3_ACCESS_KEY"),
    secret_access_key: System.fetch_env!("S3_SECRET_KEY")

  config :ex_aws, :s3,
    scheme: "http://",
    host: System.fetch_env!("MINIO_HOST"),
    port: 9000

  config :pooler, Pooler.Clients.ProcessImage.Real,
    exchange: System.get_env("RMQ_EXCHANGE", ""),
    routing_key: System.fetch_env!("PROCESS_IMAGE_ROUTING_KEY")
end

if config_env() == :prod do
  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :pooler, PoolerWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  config :pooler,
    admin_password: System.fetch_env!("POOLER_ADMIN_PASSWORD"),
    admin_email: System.fetch_env!("POOLER_ADMIN_EMAIL")
end
