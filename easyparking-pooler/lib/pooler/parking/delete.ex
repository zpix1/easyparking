defmodule Pooler.Parking.Delete do
  @moduledoc """
  Модуль с функциями для удаления парковок
  """

  alias Pooler.Clients.S3
  alias Pooler.Parking

  require Logger

  @doc """
  Удаляет парковку вместе с картинками из S3
  """
  @spec delete_by_id(String.t()) :: :ok
  def delete_by_id(parking_id) when is_binary(parking_id) do
    case Parking.get_by_id(parking_id) do
      {:ok, parking} -> delete_parking(parking, S3.get_client())
      {:error, :parking_not_found} -> :ok
    end
  end

  defp delete_parking(parking, s3_client) do
    # Удаляем через 5 мин. Это время должно быть больше, чем переодичность запуска вытягивания
    five_mins = 5 * 60 * 1000

    Task.Supervisor.start_child(
      Pooler.TaskSupervisor,
      fn ->
        :timer.sleep(five_mins)
        delete_image_from_s3(parking, s3_client)
      end,
      timeout: :infinity
    )

    Task.Supervisor.start_child(
      Pooler.TaskSupervisor,
      fn ->
        :timer.sleep(five_mins)
        delete_processed_image_from_s3(parking, s3_client)
      end,
      timeout: :infinity
    )

    Parking.delete(parking.id)
    Logger.info("Deleted parking #{parking.id}")
  end

  defp delete_image_from_s3(%Parking{image_url: nil}, _s3_client), do: :ok

  defp delete_image_from_s3(%Parking{image_url: image_url}, s3_client) do
    s3_client.delete_image!(image_url)
    Logger.info("Deleted image #{image_url} from S3")
  end

  defp delete_processed_image_from_s3(%Parking{processed_image_url: nil}, _s3_client), do: :ok

  defp delete_processed_image_from_s3(%Parking{processed_image_url: image_url}, s3_client) do
    s3_client.delete_image!(image_url)
    Logger.info("Deleted processed image #{image_url} from S3")
  end
end
