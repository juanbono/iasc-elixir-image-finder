defmodule ImageFinder.DynSup do
  use DynamicSupervisor

  def init(_args) do
    DynamicSupervisor.init([])
  end

  def spawn_and_process(source_file, target_directory) do
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, {ImageFinder.Worker, 2})
    ImageFinder.Worker.fetch(pid, source_file, target_directory)
  end
end
