defmodule Pooler.Accounts.UsersContext do
  @moduledoc """
  Модуль для Pow, который содержит колбэки для аутентификации пользователей (администратора).
  """

  def authenticate(%{"email" => email, "password" => password}) do
    admin_password = Application.fetch_env!(:pooler, :admin_password)
    admin_email = Application.fetch_env!(:pooler, :admin_email)

    if admin_password == password and admin_email == email do
      %Pooler.Accounts.Admin{id: 1}
    end
  end

  def get_by(id: 1), do: %Pooler.Accounts.Admin{id: 1}
  def get_by(_), do: nil
end
