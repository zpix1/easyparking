defmodule Pooler.Helper.Seeds do
  @moduledoc """
  Функции для заполнения базы тестовыми данными
  """
  alias Pooler.Parking

  def seed do
    [
      %{
        address: "Новосибирск, ул. Военная, 5",
        camera_endpoint:
          "http://68.188.109.50/cgi-bin/camera?resolution=640&amp;quality=1&amp;Language=0&amp;1663256640",
        latitude: 55.028857,
        longitude: 82.936342,
        title: "Парковка у Ауры"
      },
      %{
        address: "Новосибирск, ул. Гоголя, 13",
        camera_endpoint: "http://94.72.19.56/jpg/1/image.jpg",
        latitude: 55.043951,
        longitude: 82.922440,
        title: "Парковка у Галереи"
      },
      %{
        address: "Новосибирск, ул. Фрунзе, 238",
        camera_endpoint: "http://67.43.220.114/jpg/1/image.jpg",
        latitude: 55.039724,
        longitude: 82.960575,
        title: "Парковка у Сибирского Молла"
      },
      %{
        address: "Новосибирск, Красный проспект, 101",
        camera_endpoint: "http://109.236.111.203/jpg/1/image.jpg",
        latitude: 55.056077,
        longitude: 82.912726,
        title: "Парковка у Роял Парка"
      }
    ]
    |> Enum.each(&({:ok, %Parking{}} = Parking.create(&1)))
  end
end
