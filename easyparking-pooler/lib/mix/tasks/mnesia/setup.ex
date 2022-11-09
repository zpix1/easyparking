defmodule Mix.Tasks.Mnesia.Setup do
  @moduledoc false
  use Mix.Task

  @shortdoc "Sets up mnesia schemas and database on disk "
  def run(_) do
    Mix.Task.run("app.start")

    nodes = [node()]
    Memento.Schema.create(nodes)
    Pooler.Mnesia.setup(nodes)
  end
end
