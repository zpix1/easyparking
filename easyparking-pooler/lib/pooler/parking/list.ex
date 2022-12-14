defmodule Pooler.Parking.List do
  @moduledoc """
  В данном модуле содержатся функции для получения списка парковок
  """

  alias Pooler.Auxiliary
  alias Pooler.Parking
  use Scrivener

  @doc """
  Возвращает структуру пагинации с парковками, упорядоченными по удалению от пользователя
  """
  @spec list_parkings_order_by_distance_from_user(
          non_neg_integer(),
          non_neg_integer(),
          {number(), number()}
        ) ::
          Scrivener.Page.t()
  def list_parkings_order_by_distance_from_user(page, page_size, {_lat, _lng} = user_coords)
      when is_integer(page) and is_integer(page_size) do
    Parking.list_all_order_by_title()
    |> Enum.map(&add_distance_between_parking_and_user(&1, user_coords))
    |> Enum.sort_by(& &1.distance_from_user, :asc)
    |> paginate(page: page, page_size: page_size)
  end

  defp add_distance_between_parking_and_user(parking, user_coords) do
    parking
    |> Map.from_struct()
    |> Map.put(
      :distance_from_user,
      Auxiliary.Geo.distance_between_to_geo_points(parking.coordinates, user_coords)
    )
  end
end
