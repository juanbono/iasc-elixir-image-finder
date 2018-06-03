defmodule ImageFinder.FileParser.Supervisor do
  use DynamicSupervisor
  import ImageFinder.Utils
  alias ImageFinder.FileParser

  def init(_args) do
    DynamicSupervisor.init([])
  end

  def process(files) do
    children = start_worker_for_each(files, __MODULE__, FileParser.Worker)

    Enum.zip(children, files)
    |> Enum.map(fn {child, file} -> send_parse(child, file) end)

    results = wait_for_results(length(children), 0, [])
  end

  def wait_for_results(n, current, state) do
    if n != current do
      receive do
        {:parsed, links} ->
          IO.inspect("Received a link\n", label: "MSG:")
          wait_for_results(n, current + 1, [links | state])
      after
        1000 ->
          nil
      end
    else
      state
    end
  end

  defp send_parse(child, file) do
    GenServer.cast(child, {:parse, self(), file})
  end
end
