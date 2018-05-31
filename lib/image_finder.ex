defmodule ImageFinder do
  use Application

  def start(_type, _args) do
    ImageFinder.Supervisor.start_link()
  end

  def fetch(files, target_directory) do
    ImageFinder.DynSup.process(files, target_directory)
  end
end
