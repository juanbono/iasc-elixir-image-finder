defmodule ImageFinder.Worker do
  use GenServer

  def start_link(args) do
    IO.inspect(args)
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(_args) do
    {:ok, %{}}
  end

  def handle_call({:fetch, source_file, target_directory}, _from, state) do
    content = File.read!(source_file)
    regexp = ~r/http(s?)\:.*?\.(png|jpg|gif)/

    Regex.scan(regexp, content)
    |> Enum.map(&List.first/1)
    |> Enum.map(&fetch_link(&1, target_directory))

    {:reply, :ok, state}
  end

  def fetch(pid, source_file, target_directory) do
    GenServer.call(pid, {:fetch, source_file, target_directory})
  end

  def fetch_link(link, target_directory) do
    HTTPotion.get(link).body |> save(target_directory)
  end

  def digest(body) do
    :crypto.hash(:md5, body) |> Base.encode16()
  end

  def save(body, directory) do
    File.write!("#{directory}/#{digest(body)}", body)
  end
end
