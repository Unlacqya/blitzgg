defmodule Blitzgg.Riot.LoL.MatchTest do
  use ExUnit.Case, async: true

  import Mox

  alias Blitzgg.Riot.LoL.{Match, Summoner}
  alias Blitzgg.Riot.MockRiotClient

  @match_json "{\"metadata\":{\"dataVersion\":\"2\",\"matchId\":\"NA1_test_1\",\"participants\":[\"test_puuid_1\",\"test_puuid_2\",\"test_puuid_3\",\"test_puuid_4\",\"test_puuid_5\",\"test_puuid_6\",\"test_puuid_7\",\"test_puuid_8\",\"test_puuid_9\",\"test_puuid_10\"]}}"

  @match %Blitzgg.Riot.LoL.Match{
    match_id: "NA1_test_1",
    participants: [
      %Summoner{
        puuid: "test_puuid_1",
        name: "test_name_1",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_2",
        name: "test_name_2",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_3",
        name: "test_name_3",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_4",
        name: "test_name_4",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_5",
        name: "test_name_5",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_6",
        name: "test_name_6",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_7",
        name: "test_name_7",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_8",
        name: "test_name_8",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_9",
        name: "test_name_9",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      },
      %Summoner{
        puuid: "test_puuid_10",
        name: "test_name_10",
        account_id: "test_account_id",
        level: 127,
        profile_icon_id: 8934,
        revision_dt: 1_712_645_024_278,
        riot_id: "test_riot_id"
      }
    ]
  }

  describe "new/2" do
    test "returns nil for nil json" do
      assert nil == Match.new(nil, nil)
    end

    test "returns match struct from json input" do
      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_1", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_1\",\"name\":\"test_name_1\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_2", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_2\",\"name\":\"test_name_2\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_3", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_3\",\"name\":\"test_name_3\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_4", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_4\",\"name\":\"test_name_4\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_5", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_5\",\"name\":\"test_name_5\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_6", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_6\",\"name\":\"test_name_6\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_7", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_7\",\"name\":\"test_name_7\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_8", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_8\",\"name\":\"test_name_8\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_9", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_9\",\"name\":\"test_name_9\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_10", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_10\",\"name\":\"test_name_10\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      assert @match = Match.new(@match_json, "NA1")
    end
  end

  describe "get_by_id/3" do
    test "returns error for forbidden api access" do
      expect(MockRiotClient, :get_match_by_id, fn "NA_test_1", "americas" ->
        {:ok, %HTTPoison.Response{status_code: 403}}
      end)

      assert {:error, :forbidden} = Match.get_by_id("NA_test_1", "americas", "NA1")
    end

    test "returns error for summoner not found" do
      expect(MockRiotClient, :get_match_by_id, fn "NA_test_1", "americas" ->
        {:ok, %HTTPoison.Response{status_code: 404}}
      end)

      assert {:error, :match_not_found} = Match.get_by_id("NA_test_1", "americas", "NA1")
    end

    test "returns error for api rate limit exceeded" do
      expect(MockRiotClient, :get_match_by_id, fn "NA_test_1", "americas" ->
        {:ok, %HTTPoison.Response{status_code: 429}}
      end)

      assert {:error, :rate_limit_exceeded} = Match.get_by_id("NA_test_1", "americas", "NA1")
    end

    test "parses match struct from json if valid response" do
      expect(MockRiotClient, :get_match_by_id, fn "NA_test_1", "americas" ->
        {:ok, %HTTPoison.Response{body: @match_json}}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_1", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_1\",\"name\":\"test_name_1\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_2", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_2\",\"name\":\"test_name_2\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_3", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_3\",\"name\":\"test_name_3\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_4", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_4\",\"name\":\"test_name_4\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_5", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_5\",\"name\":\"test_name_5\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_6", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_6\",\"name\":\"test_name_6\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_7", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_7\",\"name\":\"test_name_7\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_8", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_8\",\"name\":\"test_name_8\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_9", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_9\",\"name\":\"test_name_9\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_10", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_10\",\"name\":\"test_name_10\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      assert @match = Match.get_by_id("NA_test_1", "americas", "NA1")
    end

    test "parses multiple match structs from json for list of match inputs" do
      expect(MockRiotClient, :get_match_by_id, fn "NA_test_1", "americas" ->
        {:ok, %HTTPoison.Response{body: @match_json}}
      end)

      expect(MockRiotClient, :get_match_by_id, fn "NA_test_2", "americas" ->
        {:ok, %HTTPoison.Response{body: @match_json}}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_1", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_1\",\"name\":\"test_name_1\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_2", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_2\",\"name\":\"test_name_2\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_3", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_3\",\"name\":\"test_name_3\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_4", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_4\",\"name\":\"test_name_4\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_5", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_5\",\"name\":\"test_name_5\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_6", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_6\",\"name\":\"test_name_6\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_7", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_7\",\"name\":\"test_name_7\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_8", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_8\",\"name\":\"test_name_8\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_9", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_9\",\"name\":\"test_name_9\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_10", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_10\",\"name\":\"test_name_10\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_1", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_1\",\"name\":\"test_name_1\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_2", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_2\",\"name\":\"test_name_2\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_3", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_3\",\"name\":\"test_name_3\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_4", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_4\",\"name\":\"test_name_4\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_5", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_5\",\"name\":\"test_name_5\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_6", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_6\",\"name\":\"test_name_6\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_7", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_7\",\"name\":\"test_name_7\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_8", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_8\",\"name\":\"test_name_8\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_9", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_9\",\"name\":\"test_name_9\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid_10", "NA1" ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid_10\",\"name\":\"test_name_10\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"
         }}
      end)

      assert [@match, @match] = Match.get_by_id(["NA_test_1", "NA_test_2"], "americas", "NA1")
    end
  end

  describe "fetch_participant_names/1" do
    test "returns nil when the input is not a match struct" do
      assert nil == Match.fetch_participant_names(nil)
    end

    test "returns list of participants given a match struct" do
      assert [
               "test_name_1",
               "test_name_2",
               "test_name_3",
               "test_name_4",
               "test_name_5",
               "test_name_6",
               "test_name_7",
               "test_name_8",
               "test_name_9",
               "test_name_10"
             ] == Match.fetch_participant_names(@match)
    end

    test "returns flattened list of participants given list of matches" do
      match_2 = %Blitzgg.Riot.LoL.Match{
        match_id: "NA1_test_1",
        participants: [
          %Summoner{puuid: "test_puuid_1", name: "test_name_11"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_12"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_13"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_14"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_15"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_16"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_17"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_18"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_19"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_20"}
        ]
      }

      assert [
               "test_name_1",
               "test_name_2",
               "test_name_3",
               "test_name_4",
               "test_name_5",
               "test_name_6",
               "test_name_7",
               "test_name_8",
               "test_name_9",
               "test_name_10",
               "test_name_11",
               "test_name_12",
               "test_name_13",
               "test_name_14",
               "test_name_15",
               "test_name_16",
               "test_name_17",
               "test_name_18",
               "test_name_19",
               "test_name_20"
             ] == Match.fetch_participant_names([@match, match_2])
    end

    test "returns flattened list of unique participants given list of matches" do
      match_2 = %Blitzgg.Riot.LoL.Match{
        match_id: "NA1_test_1",
        participants: [
          %Summoner{puuid: "test_puuid_11", name: "test_name_11"},
          %Summoner{puuid: "test_puuid_12", name: "test_name_12"},
          %Summoner{puuid: "test_puuid_13", name: "test_name_13"},
          %Summoner{puuid: "test_puuid_14", name: "test_name_14"},
          %Summoner{puuid: "test_puuid_15", name: "test_name_15"},
          %Summoner{puuid: "test_puuid_16", name: "test_name_16"},
          %Summoner{puuid: "test_puuid_17", name: "test_name_17"},
          %Summoner{puuid: "test_puuid_1", name: "test_name_1"},
          %Summoner{puuid: "test_puuid_12", name: "test_name_2"},
          %Summoner{puuid: "test_puuid3", name: "test_name_3"}
        ]
      }

      assert [
               "test_name_1",
               "test_name_2",
               "test_name_3",
               "test_name_4",
               "test_name_5",
               "test_name_6",
               "test_name_7",
               "test_name_8",
               "test_name_9",
               "test_name_10",
               "test_name_11",
               "test_name_12",
               "test_name_13",
               "test_name_14",
               "test_name_15",
               "test_name_16",
               "test_name_17"
             ] == Match.fetch_participant_names([@match, match_2])
    end
  end
end
