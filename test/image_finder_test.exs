defmodule ImageFinderTest do
  use ExUnit.Case

  test "greets the world" do
    files = ["./test/sample.txt", "./test/sample2.txt"]
    target = "./test/target/"
    ImageFinder.fetch(files, target)
    # we need to look for a better way to test this
    :timer.sleep(3000)
    number_of_files = target |> File.ls!() |> length
    # clean the target directory
    clean_test_dir(target)
    assert number_of_files == length(files)
  end

  defp clean_test_dir(dir) do
    dir
    |> File.ls!()
    |> Enum.map(fn path -> dir <> path end)
    |> Enum.each(fn path -> File.rm!(path) end)
  end
end
