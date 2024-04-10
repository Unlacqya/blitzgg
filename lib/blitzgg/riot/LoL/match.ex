defmodule Blitzgg.Riot.LoL.Match do
  @moduledoc """
  This module defines a struct for League of Legends matches
  and supporting functions.
  """

  alias Blitzgg.Riot.LoL.Summoner
  alias FE.Result

  defstruct [:match_id, :participants]

  @type t :: %__MODULE__{
          match_id: String.t(),
          participants: list(Summoner.t())
        }

  @doc """
  Creates a new match struct from json.
  """
  @spec new(nil | binary(), String.t()) :: nil | t()
  def new(nil, _region), do: nil

  def new(match_json, platform) do
    {:ok, match} = Jason.decode(match_json)

    metadata = match["metadata"]

    %__MODULE__{
      match_id: metadata["matchId"],
      participants: Enum.map(metadata["participants"], &Summoner.get_by_puuid(&1, platform))
    }
  end

  @doc """
  Fetches match information from the Riot API and returns a Match struct.
  """
  @spec get_by_id(String.t() | list(String.t()), String.t(), String.t()) ::
          {:error, atom()} | {:ok, t()}
  def get_by_id(matches, region, platform) when is_list(matches) do
    Enum.map(matches, &get_by_id(&1, region, platform))
  end

  def get_by_id(match, region, platform) do
    match
    |> riot_client().get_match_by_id(region)
    |> case do
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        Result.error(:forbidden)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Result.error(:match_not_found)

      {:ok, %HTTPoison.Response{status_code: 429}} ->
        Result.error(:rate_limit_exceeded)

      {:ok, %HTTPoison.Response{body: body}} ->
        new(body, platform)
    end
  end

  @doc """
  Takes in a match struct or list of match structs and returns
  the names of all summoners who played in those matches as a
  flat list.
  """
  @spec fetch_participant_names(any()) :: list(String.t())
  def fetch_participant_names(matches) when is_list(matches) do
    matches
    |> Enum.map(&fetch_participant_names(&1))
    |> List.flatten()
    |> Enum.uniq()
  end

  def fetch_participant_names(%__MODULE__{participants: participants}) do
    Enum.map(participants, &Summoner.get_name(&1))
  end

  def fetch_participant_names(_match), do: nil

  defp riot_client do
    Application.get_env(:blitzgg, :riot_client)
  end
end
