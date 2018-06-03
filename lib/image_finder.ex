defmodule ImageFinder do
  use Application

  alias ImageFinder.FileParser
  alias ImageFinder.Fetcher

  def start(_type, _args) do
    ImageFinder.Supervisor.start_link()
  end

  def fetch(files, target_directory) do
    # {:ok, links_per_domain}
    results = FileParser.Supervisor.process(files)
    # {:ok, info} = Fetcher.Supervisor.process(links_per_domain, target_directory)
    # do something with the info
  end
end
