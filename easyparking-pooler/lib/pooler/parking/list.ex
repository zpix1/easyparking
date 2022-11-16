defmodule Pooler.Parking.List do
  @moduledoc """
  В данном модуле содержатся функции для получения списка парковок
  """

  alias Pooler.Parking
  use Scrivener

  @doc """
  Возвращает структуру пагинации с парковками, упорядоченными по удалению от пользователя
  """
  @spec list_parkings_order_by_distance_from_user(
          non_neg_integer(),
          non_neg_integer(),
          {float(), float()}
        ) ::
          Scrivener.Page.t()
  def list_parkings_order_by_distance_from_user(page, page_size, {_lat, _lng} = user_coords)
      when is_integer(page) and is_integer(page_size) do
    Parking.list_all_order_by_title()
    |> Enum.sort_by(&distance_between_parking_and_user(&1, user_coords), :asc)
    |> paginate(page: page, page_size: page_size)
  end

  defp distance_between_parking_and_user(
         %Parking{coordinates: {lat_1, lng_1}},
         {lat_2, lng_2} = _user_coordinates
       ) do
    :math.pow(lat_1 - lat_2, 2) + :math.pow(lng_1 - lng_2, 2)
  end
end
