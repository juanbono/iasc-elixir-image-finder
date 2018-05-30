defmodule ImageFinder do
  use Application

  def start(_type, _args) do
    ImageFinder.Supervisor.start_link()
  end

  def fetch(source_file, target_directory) do
    ImageFinder.DynSup.spawn_and_process(source_file, target_directory)
  end
end
