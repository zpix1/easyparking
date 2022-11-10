defmodule PoolerWeb.Admin.ParkingView do
  @moduledoc false
  use PoolerWeb, :view

  alias Pooler.Parking

  def render("parking.json", %{parking: %Parking{} = parking}) do
    view(parking)
  end

  def render("parkings.json", %{parkings: parkings}) when is_list(parkings) do
    Enum.map(parkings, &view/1)
  end

  defp view(%Parking{} = parking) do
    {latitude, longitude} = parking.coordinates

    %{
      "id" => parking.id,
      "title" => parking.title,
      "address" => parking.address,
      "latitude" => latitude,
      "longitude" => longitude,
      "updated_at" => DateTime.to_iso8601(parking.updated_at),
      "inserted_at" => DateTime.to_iso8601(parking.inserted_at)
    }
  end
end
