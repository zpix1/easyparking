defmodule Pooler.Parking do
  @moduledoc """
  Сущность парковки в базе данных и функции для работы с ней
  """
  use Memento.Table,
    attributes: [
      :id,
      :address,
      :title,
      :camera_endpoint,
      :coordinates,
      :image_url,
      :processed_image_url,
      :inserted_at,
      :updated_at
    ],
    index: [:title],
    type: :ordered_set

  @type t :: %__MODULE__{
          id: String.t(),
          address: String.t(),
          title: String.t(),
          camera_endpoint: String.t(),
          coordinates: {float(), float()},
          # путь на S3 к необработанной картинке с камеры
          image_url: String.t() | nil,
          # путь на S3 к обработанной картинке с камеры
          processed_image_url: String.t() | nil,
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  alias Pooler.Auxiliary

  @spec create(map()) :: t()
  def create(%{} = params) do
    date_time_now = Auxiliary.Time.get_date_time_now()

    params =
      Map.merge(params, %{id: UUID.uuid1(), inserted_at: date_time_now, updated_at: date_time_now})

    parking = struct(%__MODULE__{}, params)

    Memento.transaction!(fn ->
      Memento.Query.write(parking)
    end)
  end

  @spec update(String.t(), map()) :: {:ok, t()} | {:error, :not_found}
  def update(parking_id, %{} = params) when is_binary(parking_id) do
    date_time_now = Auxiliary.Time.get_date_time_now()
    params = Map.put(params, :updated_at, date_time_now)

    Memento.transaction!(fn ->
      case Memento.Query.read(__MODULE__, parking_id, lock: :write) do
        %__MODULE__{} = parking ->
          parking
          |> struct(params)
          |> Memento.Query.write()
          |> then(&{:ok, &1})

        nil ->
          {:error, :not_found}
      end
    end)
  end

  @spec delete(String.t()) :: t()
  def delete(parking_id) when is_binary(parking_id) do
    Memento.transaction!(fn ->
      Memento.Query.delete(__MODULE__, parking_id)
    end)
  end

  @doc """
  Возвращает все парковки, отсортированные по названию от А до Я
  """
  @spec list_all_order_by_title() :: [t()]
  def list_all_order_by_title do
    Memento.transaction!(fn ->
      Memento.Query.all(__MODULE__)
    end)
    |> Enum.sort_by(& &1.title, :asc)
  end

  @spec list_by_ids([String.t()]) :: [t()]
  def list_by_ids(ids) when is_list(ids) do
    Memento.transaction!(fn ->
      Memento.Query.all(__MODULE__)
    end)
    |> Enum.filter(&(&1.id in ids))
    |> Enum.sort_by(& &1.title, :asc)
  end
end
