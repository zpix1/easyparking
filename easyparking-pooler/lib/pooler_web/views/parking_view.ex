defmodule PoolerWeb.ParkingView do
  @moduledoc false
  use PoolerWeb, :view

  alias Pooler.Clients.S3

  def render("parkings_pagination.json", %{pagination_info: %Scrivener.Page{} = pagination_info}) do
    s3_client = S3.get_client()

    %{
      "page_number" => pagination_info.page_number,
      "page_size" => pagination_info.page_size,
      "total_pages" => pagination_info.total_pages,
      "total_entries" => pagination_info.total_entries,
      "entries" => Enum.map(pagination_info.entries, &view(&1, s3_client))
    }
  end

  def render("parkings.json", %{parkings: parkings})
      when is_list(parkings) do
    s3_client = S3.get_client()

    Enum.map(parkings, &view(&1, s3_client))
  end

  defp view(parking, s3_client) do
    {latitude, longitude} = parking.coordinates

    image_presigned_url =
      if parking.image_url do
        {:ok, image_presigned_url} = s3_client.get_image_presigned_url(parking.image_url, :get)
        image_presigned_url
      end

    processed_image_presigned_url =
      if parking.processed_image_url do
        {:ok, processed_image_presigned_url} =
          s3_client.get_processed_image_presigned_url(parking.processed_image_url, :get)

        processed_image_presigned_url
      end

    %{
      "id" => parking.id,
      "title" => parking.title,
      "address" => parking.address,
      "latitude" => latitude,
      "longitude" => longitude,
      "image_url" => image_presigned_url,
      "updated_at" => DateTime.to_iso8601(parking.updated_at),
      "processed_image_url" => processed_image_presigned_url,
      "cars_found" => parking.cars_found,
      "distance_from_user" => get_in(parking, [Access.key(:distance_from_user)])
    }
  end
end
