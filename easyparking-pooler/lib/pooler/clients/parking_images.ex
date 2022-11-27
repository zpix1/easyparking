defmodule Pooler.Clients.ParkingImages do
  @moduledoc """
  Клиент для получения изображения с камер парковок
  """

  def child_spec do
    {Finch,
     name: __MODULE__,
     pools: %{
       default: [size: pool_size()]
     }}
  end

  @spec pool_size() :: integer()
  def pool_size, do: 25

  @callback get_parking_image(url :: String.t()) :: binary()

  @client Application.compile_env!(:pooler, :parking_images_client)[:client]

  @doc """
  Получает модуль - реализацию клиента из конфигуарции.
  """
  @spec get_client() :: atom()
  def get_client, do: @client
end
