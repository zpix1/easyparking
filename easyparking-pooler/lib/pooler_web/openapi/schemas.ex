defmodule PoolerWeb.OpenAPI.Schemas do
  @moduledoc false

  alias OpenApiSpex.Schema

  defmodule AdminCredentials do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Admin Credentials",
      description: "Логин и пароль администратора",
      type: :object,
      properties: %{
        email: %Schema{type: :string, minLength: 5, maxLength: 50},
        password: %Schema{type: :string, minLength: 5, maxLength: 50}
      },
      required: [:password, :email],
      example: %{
        "email" => "admin",
        "password" => "admin"
      }
    })
  end

  defmodule AdminCredentialsResponse do
    @moduledoc false
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Admin Credentials Response",
      description: """
      Access и refresh токены.
      При истечении access токена новые токены можно получить по маршруту /api/v1/session/refresh, отправляя refresh токен

      Access токен в обычном случае и refresh при истечении access токена
      необходимо передавать в HTTP заголовке Authorization в виде `"Bearer <<your token here>>"`.
      Например,
      ```
      Authorization: Bearer SFMyNTY.MWVlY2I2MDctZDMzMy00NjRjLTliYTMtOGFkYTc3OGQyMDgw.JmCB59ctQGnvx_G-LnP5i7E_zSSrthcLW25yvXqvBV8
      ```
      """,
      type: :object,
      properties: %{
        access_token: %Schema{type: :string},
        refresh_token: %Schema{type: :string}
      },
      example: %{
        "access_token" =>
          "SFMyNTY.OWVmZWI5NzAtMTM2OS00ZGFjLWEzZTktMzYxNGZmYjA5ZTZi.TkOiJQilo7DtmXkv_V1mM4hEX2EWwjbQqK6eFZPBWhg",
        "refresh_token" =>
          "SFMyNTY.MWVlY2I2MDctZDMzMy00NjRjLTliYTMtOGFkYTc3OGQyMDgw.JmCB59ctQGnvx_G-LnP5i7E_zSSrthcLW25yvXqvBV8"
      }
    })
  end

  defmodule ErrorResponse do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Error Response",
      description: """
      Структура ответа в случае ошибки в бизнес логике

      Заметьте, что ошибка при валиации в OpenAPI будет иметь вид
      ```
      {
        "errors": [
          {
            "detail": "Invalid format. Expected :date",
            "source": {
              "pointer": "/data/birthday"
            },
            "title": "Invalid value"
          }
        ]
      }
      ```
      """,
      type: :object,
      properties: %{
        error: %Schema{
          type: :object,
          properties: %{message: %Schema{type: :string, description: "Сообщение ошибки"}},
          required: [:message]
        }
      },
      required: [:error],
      example: %{
        "error" => %{"message" => "Internal Error"}
      }
    })
  end

  defmodule StatusResponse do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Status Response",
      description: "Структура ответа, когда нечего возвращать. Сейчас статус всегда равен \"ok\"",
      type: :object,
      properties: %{
        status: %Schema{type: :string, enum: ["ok"]}
      },
      required: [:status],
      example: %{
        "status" => "ok"
      }
    })
  end
end
