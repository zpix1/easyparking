defmodule Pooler.Auxiliary.Geo do
  @moduledoc """
  Вспомогательные функции для работы с геоданными
  """

  @doc """
  Вычисляет расстояние в метрах между двумя точками, заданными их географическими кординатами

  ## Пример: Расстояние между Лондоном и Арлингтоном
      iex> distance_between_to_geo_points({51.5, 0}, {38.8, -77.1})
      5918185.064088765
  """
  @spec distance_between_to_geo_points({number(), number()}, {number(), number()}) :: number()
  def distance_between_to_geo_points({lat_1, lng_1} = _point_1, {lat_2, lng_2} = _point_2) do
    d_lat = degrees_to_radians(lat_1 - lat_2)
    d_lng = degrees_to_radians(lng_1 - lng_2)
    lat_1 = degrees_to_radians(lat_1)
    lat_2 = degrees_to_radians(lat_2)

    a =
      ((d_lat / 2) |> :math.sin() |> :math.pow(2)) +
        ((d_lng / 2) |> :math.sin() |> :math.pow(2)) * :math.cos(lat_1) * :math.cos(lat_2)

    2 * 6371 * 1000 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
  end

  @spec degrees_to_radians(number()) :: number()
  def degrees_to_radians(degrees) when is_number(degrees), do: degrees * :math.pi() / 180
end
