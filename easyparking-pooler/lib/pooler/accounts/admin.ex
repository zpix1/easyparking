defmodule Pooler.Accounts.Admin do
  @moduledoc """
  Администратор приложения.

  Пока что он только один и не хранится в БД. Пароль администратора берется из переменной окружения
  """
  defstruct [:id]
end
