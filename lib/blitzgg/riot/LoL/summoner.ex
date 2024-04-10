defmodule Blitzgg.Riot.LoL.Summoner do
  @moduledoc """
  This module defines a struct for League of Legends Summoners
  and supporting functions.
  """

  alias FE.Result

  defstruct [:account_id, :riot_id, :name, :profile_icon_id, :puuid, :revision_dt, :level]

  @type t :: %__MODULE__{
          account_id: String.t(),
          riot_id: String.t(),
          name: String.t(),
          profile_icon_id: integer(),
          puuid: String.t(),
          revision_dt: integer(),
          level: integer()
        }

  @doc """
  Creates a new Summoner struct from json input.
  """
  @spec new(nil | binary()) :: nil | t()
  def new(nil), do: nil

  def new(summoner_json) do
    {:ok, summoner} = Jason.decode(summoner_json)

    %__MODULE__{
      account_id: summoner["accountId"],
      riot_id: summoner["id"],
      name: summoner["name"],
      profile_icon_id: summoner["profileIconId"],
      puuid: summoner["puuid"],
      revision_dt: summoner["revisionDate"],
      level: summoner["summonerLevel"]
    }
  end

  @doc """
  Given a summoner name and region platform, fetches a summoner from the
  Riot API and converts it to a Summoner Struct.
  """
  @spec get_by_name(String.t(), String.t()) :: {:ok, t()} | {:error, atom()}
  def get_by_name(name, platform) do
    name
    |> riot_client().get_summoner_by_name(platform)
    |> parse_summoner_resp()
  end

  @doc """
  Given a summoner puuid and region platform, fetches a summoner from the
  Riot API.
  """
  @spec get_by_name(String.t(), String.t()) :: t() | atom()
  def get_by_puuid(puuid, platform) do
    {_res, summoner} =
      puuid
      |> riot_client().get_summoner_by_puuid(platform)
      |> parse_summoner_resp()

    summoner
  end

  @doc """
  Given a summoner puuid or struct and region, fetches the summoners most recent games
  based on batch size, which defaults to 5.
  """
  @spec get_by_name(String.t(), String.t()) :: t() | atom()
  def get_match_ids(summoner_or_puuid, region, batch_size \\ 5)

  def get_match_ids(%__MODULE__{puuid: puuid}, region, batch_size) do
    get_match_ids(puuid, region, batch_size)
  end

  def get_match_ids(puuid, region, batch_size) do
    puuid
    |> riot_client().get_match_ids(region, batch_size)
    |> case do
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        Result.error(:forbidden)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Result.error(:match_ids_not_found)

      {:ok, %HTTPoison.Response{status_code: 429}} ->
        Result.error(:rate_limit_exceeded)

      {:ok, %HTTPoison.Response{body: body}} ->
        Jason.decode(body)
    end
  end

  @doc """
  Returns the name of a summoner from it's struct, returns nil
  if the input is not a summoner struct.
  """
  @spec get_name(any()) :: String.t() | nil
  def get_name(%__MODULE__{name: name}), do: name
  def get_name(_invalid_summoner), do: nil

  defp parse_summoner_resp(resp) do
    case resp do
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        Result.error(:forbidden)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Result.error(:summoner_not_found)

      {:ok, %HTTPoison.Response{status_code: 429}} ->
        Result.error(:rate_limit_exceeded)

      {:ok, %HTTPoison.Response{body: body}} ->
        body |> new() |> Result.ok()
    end
  end

  defp riot_client do
    Application.get_env(:blitzgg, :riot_client)
  end
end
