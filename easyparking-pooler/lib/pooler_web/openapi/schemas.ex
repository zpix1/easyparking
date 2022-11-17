defmodule PoolerWeb.OpenAPI.Schemas do
  @moduledoc false

  alias OpenApiSpex.Schema

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

  defmodule ParkingSchema do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Parking Entity",
      description: "Сущность парковки",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "UUID парковки"},
        address: %Schema{type: :string, minLength: 5, maxLength: 255},
        title: %Schema{type: :string, minLength: 5, maxLength: 255},
        latitude: %Schema{type: :number, minimum: -90, maximum: 90},
        longitude: %Schema{type: :number, minimum: -180, maximum: 180},
        image_url: %Schema{
          type: :string,
          minLength: 5,
          maxLength: 255,
          description: "Путь на S3 к картинке с парковки"
        },
        processed_image_url: %Schema{
          type: :string,
          minLength: 5,
          maxLength: 255,
          description: "Путь на S3 к обработанной ML картинке с парковки"
        }
      },
      required: [:id, :address, :title, :latitude, :longitude, :image_url, :processed_image_url],
      example: %{
        "id" => "cdfdaf44-ee35-11e3-846b-14109ff1a304",
        "address" => "Новосибирск, ул. Советская, 21/1",
        "title" => "Парковка у Бизнес центра",
        "latitude" => 37.0123,
        "longitude" => -102.3242,
        "image_url" => "parkings/cdfdaf44-ee35-11e3-846b-14109ff1a304/image.png",
        "procesed_image_url" =>
          "parkings/cdfdaf44-ee35-11e3-846b-14109ff1a304/processed_image.png"
      }
    })
  end

  defmodule ParkingsList do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "List of Parking Entities",
      description: "Список парковок",
      type: :array,
      items: ParkingSchema
    })
  end

  defmodule ParkingsPagination do
    @moduledoc false

    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Parkings Info with Pagination",
      description: "Информация о парковках с пагинацией",
      type: :object,
      properties: %{
        page_number: %Schema{
          type: :integer,
          description: "Номер страницы с парковками",
          minimum: 1
        },
        page_size: %Schema{
          type: :integer,
          description: "Количество парковок на странице",
          minimum: 0
        },
        total_entries: %Schema{
          type: :integer,
          description: "Количество парковок в базе всего",
          minimum: 0
        },
        total_pages: %Schema{
          type: :integer,
          description: "Количество страниц с парковками всего",
          minimum: 0
        },
        entries: ParkingsList
      },
      required: [:id, :address, :title, :latitude, :longitude, :image_url, :processed_image_url],
      example: %{
        page_number: 1,
        page_size: 1,
        total_entries: 10,
        total_pages: 10,
        entries: [
          %{
            "id" => "cdfdaf44-ee35-11e3-846b-14109ff1a304",
            "address" => "Новосибирск, ул. Советская, 21/1",
            "title" => "Парковка у Бизнес центра",
            "latitude" => 37.0123,
            "longitude" => -102.3242,
            "image_url" => "parkings/cdfdaf44-ee35-11e3-846b-14109ff1a304/image.png",
            "procesed_image_url" =>
              "parkings/cdfdaf44-ee35-11e3-846b-14109ff1a304/processed_image.png"
          }
        ]
      }
    })
  end
end
