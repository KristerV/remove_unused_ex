defmodule Mix.Tasks.RemoveUnused do
  @moduledoc """
  The core of the package. Run this task to remove unused code from your project.
  """

  use Mix.Task

  @doc """
  Runs the core of the package. You wouldn't use this directly, but rather run `mix remove_unused` in the console.
  """
  def run(_) do
    list_diagnostics()
    |> Enum.filter(&filter_unused/1)
    |> Enum.group_by(& &1.file, & &1.position)
    |> Enum.each(&remove_lines/1)
  end

  defp list_diagnostics do
    case Mix.Task.rerun("compile.elixir", ["--all-warnings", "--no-compile"]) do
      {:noop, results} -> results
      {:ok, results} -> results
      :noop -> []
      {:error, _results} -> []
    end
  end

  defp filter_unused(%{message: "unused" <> _msg}), do: true
  defp filter_unused(_), do: false

  defp remove_lines({file_path, line_numbers}) do
    tmp_file_path = file_path <> ".tmp"

    File.stream!(file_path)
    |> Stream.with_index(1)
    |> Stream.map(fn {line, i} ->
      if i in Enum.map(line_numbers, fn n -> elem(n, 0) end) do
        ""
      else
        line
      end
    end)
    |> Stream.into(File.stream!(tmp_file_path))
    |> Stream.run()

    File.cp(tmp_file_path, file_path, on_conflict: fn _, _ -> true end)
    File.rm(tmp_file_path)
  end
end
