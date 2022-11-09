defmodule PoolerWeb.API.V1.SessionController do
  use PoolerWeb, :controller
  @dialyzer {:nowarn_function, create: 2}

  alias Plug.Conn
  alias PoolerWeb.Plug.Auth

  alias PoolerWeb.OpenAPI.Schemas.{
    AdminCredentials,
    AdminCredentialsResponse,
    ErrorResponse,
    StatusResponse
  }

  use OpenApiSpex.ControllerSpecs
  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true
  tags ["auth"]
  security []

  operation :create,
    summary: "Sign In",
    description: """
    При правильных логине и пароле возвращает access и refresh токены, которые в дальнейшем могут использоваться для доступа к ресурсам

    При истечении access токена новые токены можно получить по маршруту `/api/v1/session/refresh`, отправляя refresh токен

    Access токен в обычном случае и refresh при истечении access токена
    необходимо передавать в HTTP заголовке `Authorization` в виде `"Bearer <<your token here>>"`.
    Например,
    ```
    Authorization: Bearer SFMyNTY.MWVlY2I2MDctZDMzMy00NjRjLTliYTMtOGFkYTc3OGQyMDgw.JmCB59ctQGnvx_G-LnP5i7E_zSSrthcLW25yvXqvBV8
    ```
    """,
    request_body: {"Admin Credentials", "application/json", AdminCredentials},
    responses: %{
      200 => {"Admin Credentials Response", "application/json", AdminCredentialsResponse}
    }

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(%Conn{body_params: %AdminCredentials{email: email, password: password}} = conn, _) do
    conn
    |> Pow.Plug.delete()
    |> Pow.Plug.authenticate_user(%{"email" => email, "password" => password})
    |> case do
      {:ok, conn} ->
        json(conn, %{
          access_token: conn.private.api_access_token,
          refresh_token: conn.private.api_renewal_token
        })

      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end

  operation :refresh,
    summary: "Refresh Tokens",
    description: """
    Обновляет access и refresh токены.
    """,
    parameters: [
      authoriztion: [
        in: :header,
        name: :authorization,
        description: "refresh токен в формате Authorization Bearer",
        type: :string,
        example:
          "Bearer SFMyNTY.MWVlY2I2MDctZDMzMy00NjRjLTliYTMtOGFkYTc3OGQyMDgw.JmCB59ctQGnvx_G-LnP5i7E_zSSrthcLW25yvXqvBV8"
      ]
    ],
    responses: %{
      200 => {"Admin Credentials Response", "application/json", AdminCredentialsResponse},
      401 => {"Error Response", "application/json", ErrorResponse}
    }

  @spec refresh(Conn.t(), map()) :: Conn.t()
  def refresh(conn, _params) do
    config = Pow.Plug.fetch_config(conn)

    conn
    |> Auth.renew(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{message: "Invalid token"}})

      {conn, _user} ->
        json(conn, %{
          access_token: conn.private.api_access_token,
          refresh_token: conn.private.api_renewal_token
        })
    end
  end

  operation :delete,
    summary: "Sign Out",
    description:
      "Осуществляет выход пользователя. По факту удаляет refresh токен из персистентного хранилища.",
    parameters: [
      authoriztion: [
        in: :header,
        name: :authorization,
        description: "access токен в формате Authorization Bearer",
        type: :string,
        example:
          "Bearer SFMyNTY.MWVlY2I2MDctZDMzMy00NjRjLTliYTMtOGFkYTc3OGQyMDgw.JmCB59ctQGnvx_G-LnP5i7E_zSSrthcLW25yvXqvBV8"
      ]
    ],
    responses: %{
      200 => {"Status Response", "application/json", StatusResponse}
    }

  @spec delete(Conn.t(), map()) :: Conn.t()
  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> json(%{status: :ok})
  end
end
