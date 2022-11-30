defmodule Pooler.Clients.S3 do
  @moduledoc """
  Клиент для работы с S3
  """

  @callback upload_image!(binary_image :: binary(), s3_path :: String.t()) :: :ok
  @callback delete_image!(s3_path :: String.t()) :: :ok
  @callback delete_processed_image!(s3_path :: String.t()) :: :ok

  @client Application.compile_env!(:pooler, __MODULE__)[:client]

  @doc """
  Получает модуль - реализацию клиента из конфигуарции.
  """
  @spec get_client() :: atom()
  def get_client, do: @client
end
