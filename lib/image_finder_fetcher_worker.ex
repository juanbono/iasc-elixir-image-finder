defmodule ImageFinder.Fetcher.Worker do
  use GenServer

  def fetch(pid, source_file, target_directory) do
    GenServer.cast(pid, {:fetch, source_file, target_directory})
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
