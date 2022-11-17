defmodule PoolerWeb.ParkingView do
  @moduledoc false
  use PoolerWeb, :view

  alias Pooler.Parking

  def render("parkings_pagination.json", %{pagination_info: %Scrivener.Page{} = pagination_info}) do
    %{
      "page_numer" => pagination_info.page_number,
      "page_size" => pagination_info.page_size,
      "total_pages" => pagination_info.total_pages,
      "total_entries" => pagination_info.total_entries,
      "entries" => Enum.map(pagination_info.entries, &view/1)
    }
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
      "image_url" => parking.image_url,
      "processed_image_url" => parking.processed_image_url
    }
  end
end
