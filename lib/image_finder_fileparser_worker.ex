defmodule ImageFinder.FileParser.Worker do
  use GenServer
  alias ImageFinder.FileParser

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, debug: [:trace])
  end

  def init(_args) do
    {:ok, %{}}
  end

  def handle_cast({:parse, from, source_file}, _state) do
    content = File.read!(source_file)
    regexp = ~r/http(s?)\:.*?\.(png|jpg|gif)/

    links =
      Regex.scan(regexp, content)
      |> Enum.map(fn results -> List.first(results) end)
      |> Enum.map(fn url -> extract_domain(url) end)
      |> (fn lst -> {:parsed, lst} end).()

    IO.inspect(links)

    send(from, links)
    {:noreply, :ok}
  end

  defp extract_domain(url), do: {:parsed, URI.parse(url).host, url}
end
