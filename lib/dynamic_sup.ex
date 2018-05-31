defmodule ImageFinder.DynSup do
  use DynamicSupervisor

  def init(_args) do
    DynamicSupervisor.init([])
  end

  def process(files, target_dir) do
    children = start_workers(files)

    Enum.zip(children, files)
    |> Enum.map(fn {child, file} -> send_fetch(child, file, target_dir) end)

    :ok
  end

  defp send_fetch(child, file, target_dir) do
    ImageFinder.Worker.fetch(child, file, target_dir)
  end

  defp start_workers(files) do
    files
    |> Enum.map(fn _ -> start_worker() end)
    |> Enum.map(fn {_, pid} -> pid end)
  end

  defp start_worker() do
    DynamicSupervisor.start_child(__MODULE__, ImageFinder.Worker)
  end
end
