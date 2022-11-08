defmodule Pooler.Mnesia do
  @moduledoc """
  Функции для работы с базой данных Mnesia
  """
  @schemas [
    Pooler.Parking
  ]

  def setup(nodes) when is_list(nodes) do
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()

    Enum.each(@schemas, fn schema ->
      Memento.Table.create(schema, disc_copies: nodes)
    end)
  end

  def reset(nodes) when is_list(nodes) do
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()

    Enum.each(@schemas, fn schema ->
      Memento.Table.delete(schema)
      Memento.Table.create!(schema, disc_copies: nodes)
    end)
  end
end
