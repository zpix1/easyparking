defmodule PoolerWeb.OpenAPI.Admin.Schemas do
  @moduledoc false

  alias OpenApiSpex.Schema

  defmodule Credentials do
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

  defmodule CredentialsResponse do
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

  defmodule ParkingParams do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Admin Panel: Parking Create Parameters",
      description: "Параметры для создания или обновления парковки из админки",
      type: :object,
      properties: %{
        address: %Schema{type: :string, minLength: 5, maxLength: 255},
        title: %Schema{type: :string, minLength: 5, maxLength: 255},
        camera_endpoint: %Schema{
          type: :string,
          format: ~r/^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/[\d\w\/_-]*$/
        },
        latitude: %Schema{type: :number, minimum: -90, maximum: 90},
        longitude: %Schema{type: :number, minimum: -180, maximum: 180}
      },
      required: [:address, :title, :camera_endpoint, :latitude, :longitude],
      example: %{
        "address" => "Новосибирск, ул. Советская, 21/1",
        "title" => "Парковка у Бизнес центра",
        "camera_endpoint" => "192.168.0.1/get-image",
        "latitude" => 37.0123,
        "longitude" => -102.3242
      }
    })
  end

  defmodule ParkingSchema do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Admin Panel: Parking Entity",
      description: "Сущность парковки в админке",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "UUID парковки"},
        address: %Schema{type: :string, minLength: 5, maxLength: 255},
        title: %Schema{type: :string, minLength: 5, maxLength: 255},
        camera_endpoint: %Schema{
          type: :string,
          format: ~r/^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/[\d\w\/_-]*$/
        },
        latitude: %Schema{type: :number, minimum: -90, maximum: 90},
        longitude: %Schema{type: :number, minimum: -180, maximum: 180},
        updated_at: %Schema{type: :string, format: :"date-time"},
        inserted_at: %Schema{type: :string, format: :"date-time"}
      },
      required: [:id, :address, :title, :camera_endpoint, :latitude, :longitude],
      example: %{
        "id" => "cdfdaf44-ee35-11e3-846b-14109ff1a304",
        "address" => "Новосибирск, ул. Советская, 21/1",
        "title" => "Парковка у Бизнес центра",
        "camera_endpoint" => "192.168.0.1/get-image",
        "latitude" => 37.0123,
        "longitude" => -102.3242,
        "updated_at" => "2022-11-09T11:21:38.938786+07:00",
        "inserted_at" => "2022-11-09T11:21:38.938786+07:00"
      }
    })
  end

  defmodule ParkingsList do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Admin Panel: List of Parking Entities",
      description: "Список парковок в админке",
      type: :array,
      items: ParkingSchema
    })
  end
end
