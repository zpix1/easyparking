defmodule Pooler.Parking.PoolImages do
  @moduledoc """
  В данном модуле содержаться функции для выкачивания картинок из камер,
  их загрузку на S3 и сохранение ссылок в базу
  """
  alias Pooler.Clients.ParkingImages
  alias Pooler.Parking

  @spec pool_images(atom(), atom(), atom()) :: :ok
  def pool_images(parking_images_client, s3_client, process_image_client) do
    parkings = Parking.list_all()

    Task.Supervisor.async_stream_nolink(
      Pooler.TaskSupervisor,
      parkings,
      fn parking ->
        parking_image = parking_images_client.get_parking_image(parking.camera_endpoint)
        s3_path = "#{parking.id}.png"
        s3_client.upload_image!(parking_image, s3_path)
        {:ok, %Parking{}} = Parking.update(parking.id, %{image_url: s3_path})
        process_image_client.process_image(parking.id, s3_path)
      end,
      restart: :transient,
      max_concurrency: ParkingImages.pool_size(),
      ordered: false
    )
    |> Stream.run()
  end
end
