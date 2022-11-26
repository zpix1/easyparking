defmodule Mix.Tasks.Mnesia.Setup do
  @moduledoc false
  use Mix.Task
  alias Pooler.Helper.Seeds

  @shortdoc "Sets up mnesia schemas and database on disk"
  def run(_args) do
    Mix.Task.run("app.start")

    nodes = [node()]
    Pooler.Mnesia.setup(nodes)
    Seeds.seed()
  end
end
