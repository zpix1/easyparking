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
    type: :set

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

  @spec create(map()) :: {:ok, t()} | {:error, :title_not_unique}
  def create(%{} = params) do
    date_time_now = Auxiliary.Time.get_date_time_now()

    params =
      Map.merge(params, %{id: UUID.uuid1(), inserted_at: date_time_now, updated_at: date_time_now})

    parking = struct(%__MODULE__{}, params)

    Memento.Transaction.execute_sync!(fn ->
      case check_constraints(parking) do
        :ok -> {:ok, Memento.Query.write(parking)}
        error -> error
      end
    end)
  end

  @spec update(String.t(), map()) :: {:ok, t()} | {:error, :not_found | :title_not_unique}
  def update(parking_id, %{} = params) when is_binary(parking_id) do
    date_time_now = Auxiliary.Time.get_date_time_now()
    params = Map.put(params, :updated_at, date_time_now)

    Memento.transaction!(fn ->
      with %__MODULE__{} = parking <- Memento.Query.read(__MODULE__, parking_id, lock: :write),
           new_parking = struct(parking, params),
           :ok <- check_constraints(new_parking) do
        new_parking
        |> Memento.Query.write()
        |> then(&{:ok, &1})
      else
        nil ->
          {:error, :not_found}

        error ->
          error
      end
    end)
  end

  @spec delete(String.t()) :: :ok
  def delete(parking_id) when is_binary(parking_id) do
    Memento.transaction!(fn ->
      Memento.Query.delete(__MODULE__, parking_id)
    end)
  end

  @spec get_by_id(String.t()) :: {:ok, t()} | {:error, :parking_not_found}
  def get_by_id(parking_id) do
    Memento.transaction!(fn ->
      Memento.Query.read(__MODULE__, parking_id)
    end)
    |> case do
      nil -> {:error, :parking_not_found}
      parking -> {:ok, parking}
    end
  end

  @spec list_all() :: [t()]
  def list_all do
    Memento.transaction!(fn ->
      Memento.Query.all(__MODULE__)
    end)
  end

  @doc """
  Возвращает все парковки, отсортированные по названию от А до Я
  """
  @spec list_all_order_by_title() :: [t()]
  def list_all_order_by_title do
    list_all()
    |> Enum.sort_by(& &1.title, :asc)
  end

  @spec list_by_ids([String.t()]) :: [t()]
  def list_by_ids(ids) when is_list(ids) do
    Memento.transaction!(fn ->
      Memento.Query.all(__MODULE__)
    end)
    |> Enum.filter(&(&1.id in ids))
    |> Enum.sort_by(fn parking -> Enum.find_index(ids, &(&1 == parking.id)) end, :asc)
  end

  defp check_constraints(%__MODULE__{id: id, title: title}) do
    case Memento.Query.select(__MODULE__, {:==, :title, title}) do
      [] -> :ok
      [%__MODULE__{id: ^id, title: ^title}] -> :ok
      _ -> {:error, :title_not_unique}
    end
  end
end
