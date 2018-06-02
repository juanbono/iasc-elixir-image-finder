defmodule ImageFinderTest do
  use ExUnit.Case

  @test_file1 "./test/sample.txt"
  @test_file2 "./test/sample2.txt"
  @target_directory "./test/target/"

  test "ImageFinder.fetch works fine" do
    files = [@test_file1, @test_file2]
    target = @target_directory
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
