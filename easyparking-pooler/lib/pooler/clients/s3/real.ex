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

  @doc """
  Создает presigned url для загрузки/получения картинки с `s3_path`
  """
  @spec get_image_presigned_url(s3_path :: String.t(), method :: :put | :get) ::
          {:ok, presigned_url :: String.t()} | {:error, String.t()}
  def get_image_presigned_url(s3_path, method)
      when is_binary(s3_path) and method in [:put, :get] do
    get_presigned_url(images_bucket(), s3_path, method)
  end

  @doc """
  Создает presigned url для загрузки/получения обработанной картиники с `s3_path`
  """
  @spec get_processed_image_presigned_url(s3_path :: String.t(), method :: :put | :get) ::
          {:ok, presigned_url :: String.t()} | {:error, String.t()}
  def get_processed_image_presigned_url(s3_path, method)
      when is_binary(s3_path) and method in [:put, :get] do
    get_presigned_url(processed_images_bucket(), s3_path, method)
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

  @doc """
  Возвращает количество секунд, в течение которых будет активна любая сгенерированная сервером presigned url
  """
  @spec presigned_url_expire_time :: integer()
  def presigned_url_expire_time do
    :pooler
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:presigned_url_expires, 20 * 60)
  end

  defp get_presigned_url(bucket, s3_path, method) do
    :s3
    |> ExAws.Config.new(host: download_host(), port: download_port())
    |> ExAws.S3.presigned_url(method, bucket, s3_path, expires_in: presigned_url_expire_time())
  end

  defp download_host, do: Application.fetch_env!(:pooler, __MODULE__)[:download_host]
  defp download_port, do: Application.fetch_env!(:pooler, __MODULE__)[:download_port]

  defp images_bucket, do: Application.fetch_env!(:pooler, __MODULE__)[:images_bucket]

  defp processed_images_bucket,
    do: Application.fetch_env!(:pooler, __MODULE__)[:processed_images_bucket]
end
