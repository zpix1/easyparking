defmodule Pooler.Broadway do
  @moduledoc """
  В данном модуле описана обработка сообщений из RabbitMQ
  """
  use Broadway

  def queue, do: Application.fetch_env!(:pooler, __MODULE__)[:queue]
  def rmq_url, do: Application.fetch_env!(:pooler, __MODULE__)[:rmq_url]

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: MyBroadway,
      producer: [
        module:
          {BroadwayRabbitMQ.Producer,
           queue: queue(), declare: [durable: true], on_failure: :ack, connection: rmq_url()},
        concurrency: 1
      ],
      processors: [
        update_parking_info: [
          concurrency: 25
        ]
      ]
    )
  end

  @impl true
  def handle_message(:update_parking_info, %Broadway.Message{data: data} = message, _) do
    data = Jason.decode!(data)
    parking_id = data["image_id"]
    cars_found = data["num_cars"]
    processed_image_url = data["processed_image_name"]

    {:ok, _} =
      Pooler.Parking.update(parking_id, %{
        cars_found: cars_found,
        processed_image_url: processed_image_url
      })

    message
  end
end
