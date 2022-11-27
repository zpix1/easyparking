defmodule Pooler.Clients.S3.Real do
  @moduledoc """
  Функции для работы с файлами на S3
  """

  @spec upload_image!(binary_image :: binary(), s3_path :: String.t()) :: :ok
  def upload_image!(binary_image, s3_path) do
    ExAws.S3.put_object(images_bucket(), s3_path, binary_image)
    |> ExAws.request!()

    :ok
  end

  @spec upload_processed_image!(binary_image :: binary(), s3_path :: String.t()) :: :ok
  def upload_processed_image!(binary_image, s3_path) do
    ExAws.S3.put_object(processed_images_bucket(), s3_path, binary_image)
    |> ExAws.request!()

    :ok
  end

  @spec delete_image!(s3_path :: String.t()) :: :ok
  def delete_image!(s3_path) do
    ExAws.S3.delete_object(images_bucket(), s3_path)
    |> ExAws.request!()

    :ok
  end

  @spec delete_processed_image!(s3_path :: String.t()) :: :ok
  def delete_processed_image!(s3_path) do
    ExAws.S3.delete_object(processed_images_bucket(), s3_path)
    |> ExAws.request!()

    :ok
  end

  defp images_bucket, do: Application.fetch_env!(:pooler, :images_bucket)
  defp processed_images_bucket, do: Application.fetch_env!(:pooler, :processed_images_bucket)
end
