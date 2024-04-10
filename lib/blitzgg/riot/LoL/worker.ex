defmodule Blitzgg.Riot.LoL.Worker do
  @moduledoc """
  This is the main module of this Elixir project.
  """

  alias Blitzgg.Riot.LoL.{Region, Match, Summoner}
  alias FE.Result

  @doc """
  Main function for the blitz interview project, the run functions
  prompts the user for a summoner name and region platform.  It then
  posts all summoners this player has played with over their last 5
  games, and watches all of these summoners for the next hour, posting
  to the command line when anyt of them finishes a new game.
  """
  @spec run() :: :ok
  def run do
    Map.new()
    |> fetch_summoner_name()
    |> fetch_platform()
    |> convert_to_region()
    |> Result.and_then(&get_summoner/1)
    |> Result.and_then(&get_match_ids/1)
    |> Result.and_then(&get_match_history/1)
    |> Result.and_then(&post_summoner_names/1)
    |> Result.and_then(&initialize_summoner_monitor/1)
    |> Result.and_then(&monitor_summoners/1)
    |> case do
      {:error, :invalid_platform} ->
        IO.write("Invalid region platform, please try again.")

      {:error, :summoner_not_found} ->
        IO.write("Summoner not found, please try again.")

      {:error, :forbidden} ->
        IO.write("Access to Riot API forbidden, do you have a valid API key?")

      {:error, :rate_limit_exceeded} ->
        IO.write("Riot API Rate Limit Exceeded.")

      _args ->
        :ok
    end
  end

  defp fetch_summoner_name(args) do
    summoner_name =
      "Please Enter a Summoner Name: "
      |> IO.gets()
      |> String.trim()

    Map.put(args, :summoner_name, summoner_name)
  end

  defp fetch_platform(args) do
    platform =
      "Please Enter a Region Platform (eg: NA1): "
      |> IO.gets()
      |> String.trim()
      |> String.upcase()

    Map.put(args, :platform, platform)
  end

  defp convert_to_region(%{platform: platform} = args) do
    platform
    |> Region.platform_to_region()
    |> Result.and_then(&add_to_args(args, :region, &1))
  end

  defp get_summoner(%{summoner_name: summoner_name, platform: platform} = args) do
    summoner_name
    |> Summoner.get_by_name(platform)
    |> Result.and_then(&add_to_args(args, :summoner, &1))
  end

  defp get_match_ids(%{summoner: summoner, region: region} = args) do
    summoner
    |> Summoner.get_match_ids(region)
    |> Result.and_then(&add_to_args(args, :match_ids, &1))
  end

  defp get_match_history(%{match_ids: match_ids, region: region, platform: platform} = args) do
    match_history = Match.get_by_id(match_ids, region, platform)

    add_to_args(args, :match_history, match_history)
  end

  defp post_summoner_names(%{match_history: match_history} = args) do
    match_history
    |> Match.fetch_participant_names()
    |> IO.inspect()

    Result.ok(args)
  end

  defp initialize_summoner_monitor(%{match_history: match_history, region: region} = args) do
    params =
      match_history
      |> Enum.map(fn match ->
        match.participants
      end)
      |> List.flatten()
      |> Enum.map(fn summoner ->
        {:ok, [match]} = Summoner.get_match_ids(summoner, region, 1)

        Map.put(summoner, :last_match, match)
      end)

    add_to_args(args, :monitor_params, params)
  end

  defp monitor_summoners(%{monitor_params: monitor_params, region: region}) do
    :timer.sleep(60000)

    1..60
    |> Enum.each(fn _i ->
      :timer.sleep(60000)

      monitor_params
      |> Enum.map(fn summoner ->
        {:ok, [match]} = Summoner.get_match_ids(summoner, region, 1)

        if match != summoner.last_match do
          IO.puts("Summoner #{summoner.name} completed match #{match}")

          Map.put(summoner, :last_match, match.id)
        end
      end)
    end)
  end

  defp add_to_args(args, key, value) do
    args
    |> Map.put(key, value)
    |> Result.ok()
  end
end
