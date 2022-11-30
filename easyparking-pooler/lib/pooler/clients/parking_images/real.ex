defmodule Pooler.Clients.ParkingImages.Real do
  @moduledoc """
  Клиент для получения изображения с камер парковок
  """

  @behaviour Pooler.Clients.ParkingImages

  alias Finch.Response

  @spec get_parking_image(String.t()) :: binary()
  def get_parking_image(parking_endpoint) when is_binary(parking_endpoint) do
    :get
    |> Finch.build(parking_endpoint)
    |> Finch.request(Pooler.Clients.ParkingImages)
    |> then(fn {:ok, %Response{body: image}} ->
      image
    end)
  end
end
