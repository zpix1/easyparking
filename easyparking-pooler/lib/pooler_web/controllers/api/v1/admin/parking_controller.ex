defmodule PoolerWeb.API.V1.Admin.ParkingController do
  use PoolerWeb, :controller

  @dialyzer [
    {:nowarn_function, create: 2},
    {:nowarn_function, update: 2},
    {:nowarn_function, delete: 2}
  ]

  alias Plug.Conn
  alias Pooler.Parking

  alias PoolerWeb.OpenAPI.Schemas.{
    ErrorResponse,
    StatusResponse
  }

  alias PoolerWeb.OpenAPI.Admin.Schemas.{
    ParkingParams,
    ParkingSchema,
    ParkingsList
  }

  use OpenApiSpex.ControllerSpecs
  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true
  tags ["admin:parkings"]
  security [%{"authorization" => []}]

  plug :put_view, PoolerWeb.Admin.ParkingView

  operation :create,
    summary: "Create Parking Entity",
    description: "Создание парковки",
    request_body: {"Parking Create Parameters", "application/json", ParkingParams},
    responses: %{
      200 => {"Parking Entity", "application/json", ParkingSchema}
    }

  @spec create(Conn.t(), any()) :: Conn.t()
  def create(%Conn{body_params: %ParkingParams{} = parking_params} = conn, _) do
    create_params = %{
      address: parking_params.address,
      title: parking_params.title,
      camera_endpoint: parking_params.camera_endpoint,
      coordinates: {parking_params.latitude, parking_params.longitude}
    }

    case Parking.create(create_params) do
      {:ok, %Parking{} = parking} ->
        render(conn, "parking.json", parking: parking)

      {:error, error} when is_atom(error) ->
        conn
        |> put_status(400)
        |> json(%{"error" => %{"message" => to_string(error)}})
    end
  end

  operation :update,
    summary: "Update Parking Entity",
    description: "Обновление  парковки",
    parameters: [
      id: [
        in: :path,
        description: "Parking ID (UUID)",
        type: :string,
        example: "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      ]
    ],
    request_body: {"Parking Update Parameters", "application/json", ParkingParams},
    responses: %{
      200 => {"Updated Parking Entity", "application/json", ParkingSchema},
      400 => {"Error Response", "application/json", ErrorResponse}
    }

  @spec update(Conn.t(), any()) :: Conn.t()
  def update(
        %Conn{body_params: %ParkingParams{} = parking_params, params: %{id: parking_id}} = conn,
        _
      ) do
    update_params = %{
      address: parking_params.address,
      title: parking_params.title,
      camera_endpoint: parking_params.camera_endpoint,
      coordinates: {parking_params.latitude, parking_params.longitude}
    }

    case Parking.update(parking_id, update_params) do
      {:ok, %Parking{} = parking} ->
        render(conn, "parking.json", parking: parking)

      {:error, error} when is_atom(error) ->
        conn
        |> put_status(400)
        |> json(%{"error" => %{"message" => to_string(error)}})
    end
  end

  operation :delete,
    summary: "Delete Parking Entity",
    description: "Удаление парковки из БД",
    parameters: [
      id: [
        in: :path,
        description: "Parking ID (UUID)",
        type: :string,
        example: "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      ]
    ],
    responses: %{
      200 => {"Status Response", "application/json", StatusResponse}
    }

  @spec delete(Conn.t(), any()) :: Conn.t()
  def delete(%Conn{params: %{id: parking_id}} = conn, _) do
    Parking.Delete.delete_by_id(parking_id)

    json(conn, %{"status" => "ok"})
  end

  operation :index,
    summary: "List Parkings",
    description: "Получение списка всех парковок. Парковки отсортированы по названию от А до Я",
    responses: %{
      200 => {"List of Parkings", "application/json", ParkingsList}
    }

  @spec index(Conn.t(), any()) :: Conn.t()
  def index(%Conn{} = conn, _) do
    parkings = Parking.list_all_order_by_title()

    render(conn, "parkings.json", parkings: parkings)
  end
end
