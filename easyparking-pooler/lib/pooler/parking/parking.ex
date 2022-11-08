defmodule Pooler.Parking do
  @moduledoc """
  Сущность парковки в базе данных
  """
  use Memento.Table,
    attributes: [:id, :address, :title, :camera_endpoint, :coordinates],
    index: [:title],
    type: :ordered_set,
    autoincrement: true

  @type t :: %__MODULE__{
          id: integer(),
          address: String.t(),
          title: String.t(),
          camera_endpoint: String.t(),
          coordinates: {float(), float()}
        }
end
