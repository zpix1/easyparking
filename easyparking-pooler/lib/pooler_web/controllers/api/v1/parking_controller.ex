defmodule PoolerWeb.API.V1.ParkingController do
  use PoolerWeb, :controller

  @dialyzer [
    {:nowarn_function, list_order_by_distance: 2},
    {:nowarn_function, list_by_ids: 2}
  ]
  alias OpenApiSpex.Schema

  alias Plug.Conn
  alias Pooler.Parking

  alias PoolerWeb.OpenAPI.Schemas.{ParkingsList, ParkingsPagination}

  use OpenApiSpex.ControllerSpecs
  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true
  tags ["parkings"]

  plug :put_view, PoolerWeb.ParkingView

  operation :list_order_by_distance,
    summary: "List Parkings Order By Distance From User",
    description: """
    Получает список парковок, отсортированных по удалению от пользователя.
    В данном запросе используется пагинация
    """,
    parameters: [
      user_latitude: [
        in: :query,
        description: "User Latitude (from -90 to 90)",
        schema: %Schema{type: :number, minimum: -90, maximum: 90},
        example: 33.5854
      ],
      user_longitude: [
        in: :query,
        description: "User Longitude (from -180 to 180)",
        schema: %Schema{type: :number, minimum: -180, maximum: 180},
        example: -15.3333
      ],
      page: [
        in: :query,
        description: "Номер страницы c парковками, начиная с 1",
        schema: %Schema{type: :integer, minimum: 1},
        example: 1
      ],
      page_size: [
        in: :query,
        description: "Количество парковок на странице",
        schema: %Schema{type: :integer, minimum: 1},
        example: 10
      ]
    ],
    responses: %{
      200 => {"Parkings with pagination", "application/json", ParkingsPagination}
    }

  @spec list_order_by_distance(Conn.t(), any()) :: Conn.t()
  def list_order_by_distance(%Conn{params: params} = conn, _) do
    pagination_info =
      Parking.List.list_parkings_order_by_distance_from_user(
        params.page,
        params.page_size,
        {params.user_latitude, params.user_longitude}
      )

    render(conn, "parkings_pagination.json", pagination_info: pagination_info)
  end

  operation :list_by_ids,
    summary: "List Parkings By Ids",
    description: """
    Получает список парковок c данными айдишниками.

    Примечание: генерируемый запрос в swagger не работает. Нужно добавить [] после каждого ids.

    Пример:
    `http://localhost:4000/api/v1/parkings-by-ids?ids[]=d1fd8fd8-65a5-11ed-bacf-acde48001122&ids[]=084e10a8-65a6-11ed-b8da-acde48001122`
    """,
    parameters: [
      ids: [
        in: :query,
        description: "Список ID парковок, которые нужно получить",
        schema: %Schema{type: :array, items: %Schema{type: :string, minLength: 5, maxLength: 255}},
        example: ["d1fd8fd8-65a5-11ed-bacf-acde48001122", "084e10a8-65a6-11ed-b8da-acde48001122"]
      ]
    ],
    responses: %{
      200 => {"Parkings with given ids", "application/json", ParkingsList}
    }

  @spec list_by_ids(Conn.t(), any()) :: Conn.t()
  def list_by_ids(%Conn{params: %{ids: ids}} = conn, _) do
    parkings = Parking.list_by_ids(ids)

    render(conn, "parkings.json", parkings: parkings)
  end
end
