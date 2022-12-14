import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pooler, PoolerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "X0sxkhjovwPqkbDpA/mjggnHOQPYb4/OBqSXmTOIxosj3lqTEJRYvV8NQpdaAxW0",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :pooler, Pooler.Clients.ParkingImages, client: nil
config :pooler, Pooler.Clients.S3, client: nil
config :pooler, Pooler.Clients.ProcessImage, client: nil
