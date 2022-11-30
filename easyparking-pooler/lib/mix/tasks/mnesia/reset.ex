defmodule Mix.Tasks.Mnesia.Reset do
  @moduledoc false
  use Mix.Task

  alias Pooler.Helper.Seeds

  @shortdoc "Resets mnesia schemas and database on disk"
  @impl true
  def run(_args) do
    Mix.Task.run("app.start")

    nodes = [node()]
    Pooler.Mnesia.reset(nodes)
    Seeds.seed()
  end
end
