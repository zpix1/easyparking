defmodule Mix.Tasks.Mnesia.Reset do
  @moduledoc false
  use Mix.Task

  @shortdoc "Resets mnesia schemas and database on disk "
  def run(_) do
    Mix.Task.run("app.start")

    nodes = [node()]
    Pooler.Mnesia.reset(nodes)
  end
end
