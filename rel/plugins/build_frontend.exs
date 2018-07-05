defmodule ElixirReact.BuildFrontend do
  use Mix.Releases.Plugin

  def before_assembly(%Release{} = release, _opts) do
    IO.puts "Building frontend..."
    case System.cmd "yarn", ["build", "--color"], cd: frontend_dir() do

      # Built frontend ok
      {output, 0} ->
        IO.puts output
        release

      # There was an error when building
      {error, _} ->
        IO.puts error
        nil
    end
  end

  def frontend_dir(), do: "#{File.cwd!}/apps/frontend"

  def after_assembly(%Release{} = release, _opts), do: release
  def before_package(%Release{} = release, _opts), do: release
  def after_package(%Release{} = release, _opts), do: release

  def after_cleanup(_args, _opts), do: :ok

end
