defmodule ImageFinder.DynSup do
  use DynamicSupervisor

  def init(_args) do
    DynamicSupervisor.init([])
  end

  def spawn_and_process(files, target_directory) do
    children =
      files
      |> Enum.map(fn _ ->
        DynamicSupervisor.start_child(__MODULE__, ImageFinder.Worker)
      end)
      |> Enum.map(fn {_, pid} -> pid end)

    Enum.zip(children, files)
    |> Enum.map(fn {child, file} ->
      ImageFinder.Worker.fetch(child, file, target_directory)
    end)
  end
end
