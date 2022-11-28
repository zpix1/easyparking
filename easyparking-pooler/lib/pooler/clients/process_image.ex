defmodule Pooler.Clients.ProcessImage do
  @moduledoc """
  Клиент для отправки картинки на обработку в сервис ML
  """

  @callback process_image(parking_id :: String.t(), image_url :: String.t()) :: :ok

  @client Application.compile_env!(:pooler, __MODULE__)[:client]

  @doc """
  Получает модуль - реализацию клиента из конфигуарции.
  """
  @spec get_client() :: atom()
  def get_client, do: @client
end
