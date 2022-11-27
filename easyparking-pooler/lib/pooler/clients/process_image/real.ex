defmodule Pooler.Clients.ProcessImage.Real do
  @moduledoc """
  Клиент, который отправляет сообщение в RabbitMQ на обработку картинки ML сервисом
  """
  @behaviour Pooler.Clients.ProcessImage

  def exchange, do: Application.get_env(:pooler, __MODULE__)[:exchange]
  def routing_key, do: Application.get_env(:pooler, __MODULE__)[:routing_key]

  @impl true
  def process_image(parking_id, image_url) when is_binary(parking_id) and is_binary(image_url) do
    payload =
      %{
        "image_id" => parking_id,
        "image_name" => image_url
      }
      |> Jason.encode!()

    {:ok, channel} = AMQP.Application.get_channel(:producer)

    :ok = AMQP.Basic.publish(channel, exchange(), routing_key(), payload, persistent: true)
  end
end
