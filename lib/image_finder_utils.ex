defmodule ImageFinder.Utils do
  def start_worker_for_each(list, supervisor, type) do
    list
    |> Enum.map(fn _ -> start_worker(supervisor, type) end)
    |> Enum.map(fn {_, pid} -> pid end)
  end

  defp start_worker(supervisor, type) do
    DynamicSupervisor.start_child(supervisor, type)
  end
end
