defmodule Pooler.Auxiliary.Time do
  @moduledoc """
  Вспомогательные функции для работы со временем
  """

  @timezone Application.compile_env!(:pooler, :timezone)

  @spec get_date_time_now() :: DateTime.t()
  def get_date_time_now do
    DateTime.now!(@timezone)
  end
end
