defmodule ImageFinder.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_args) do
    children = [
      # {DynamicSupervisor, name: ImageFinder.Fetcher.Supervisor, strategy: :one_for_one},
      {DynamicSupervisor, name: ImageFinder.FileParser.Supervisor, strategy: :one_for_one}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
