defmodule Pooler.Mnesia do
  @moduledoc """
  Функции для работы с базой данных Mnesia
  """
  @tables [
    Pooler.Parking
  ]

  @dialyzer [{:nowarn_function, setup: 1}, {:nowarn_function, reset: 1}]

  def setup(nodes) when is_list(nodes) do
    case Memento.wait(@tables, 1000) do
      {:timeout, @tables} ->
        Memento.stop()
        Memento.Schema.create(nodes)
        Memento.start()

        Enum.each(@tables, fn table ->
          Memento.Table.wait(table)
          Memento.Table.create(table, disc_copies: nodes)
        end)

      _ ->
        :ok
    end
  end

  def reset(nodes) when is_list(nodes) do
    Memento.stop()
    Memento.Schema.delete(nodes)
    Memento.Schema.create(nodes)
    Memento.start()

    Enum.each(@tables, fn table ->
      Memento.Table.wait(table)
      Memento.Table.delete(table)
      Memento.Table.create!(table, disc_copies: nodes)
    end)
  end
end
