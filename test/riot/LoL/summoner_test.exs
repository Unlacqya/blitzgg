defmodule Blitzgg.Riot.LoL.SummonerTest do
  use ExUnit.Case, async: true

  import Mox

  alias Blitzgg.Riot.LoL.Summoner
  alias Blitzgg.Riot.MockRiotClient

  @summoner_json "{\"id\":\"test_riot_id\",\"accountId\":\"test_account_id\",\"puuid\":\"test_puuid\",\"name\":\"test_summoner\",\"profileIconId\":8934,\"revisionDate\":1712645024278,\"summonerLevel\":127}"

  @summoner %Summoner{
    account_id: "test_account_id",
    level: 127,
    name: "test_summoner",
    profile_icon_id: 8934,
    puuid: "test_puuid",
    revision_dt: 1_712_645_024_278,
    riot_id: "test_riot_id"
  }

  describe "new/1" do
    test "returns nil for nil input" do
      assert nil == Summoner.new(nil)
    end

    test "returns summoner struct for json input" do
      assert @summoner == Summoner.new(@summoner_json)
    end
  end

  describe "get_by_name/2" do
    test "returns error for forbidden api access" do
      expect(MockRiotClient, :get_summoner_by_name, fn "test_summoner", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 403}}
      end)

      assert {:error, :forbidden} = Summoner.get_by_name("test_summoner", "NA1")
    end

    test "returns error for summoner not found" do
      expect(MockRiotClient, :get_summoner_by_name, fn "test_summoner", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 404}}
      end)

      assert {:error, :summoner_not_found} = Summoner.get_by_name("test_summoner", "NA1")
    end

    test "returns error for api rate limit exceeded" do
      expect(MockRiotClient, :get_summoner_by_name, fn "test_summoner", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 429}}
      end)

      assert {:error, :rate_limit_exceeded} = Summoner.get_by_name("test_summoner", "NA1")
    end

    test "parses summoner struct from json if valid response" do
      expect(MockRiotClient, :get_summoner_by_name, fn "test_summoner", "NA1" ->
        {:ok, %HTTPoison.Response{body: @summoner_json}}
      end)

      assert {:ok, @summoner} = Summoner.get_by_name("test_summoner", "NA1")
    end
  end

  describe "get_by_puuid/2" do
    test "returns error for forbidden api access" do
      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 403}}
      end)

      assert :forbidden = Summoner.get_by_puuid("test_puuid", "NA1")
    end

    test "returns error for summoner not found" do
      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 404}}
      end)

      assert :summoner_not_found = Summoner.get_by_puuid("test_puuid", "NA1")
    end

    test "returns error for api rate limit exceeded" do
      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid", "NA1" ->
        {:ok, %HTTPoison.Response{status_code: 429}}
      end)

      assert :rate_limit_exceeded = Summoner.get_by_puuid("test_puuid", "NA1")
    end

    test "parses summoner struct from json if valid response" do
      expect(MockRiotClient, :get_summoner_by_puuid, fn "test_puuid", "NA1" ->
        {:ok, %HTTPoison.Response{body: @summoner_json}}
      end)

      assert @summoner = Summoner.get_by_puuid("test_puuid", "NA1")
    end
  end

  describe "get_match_ids/3" do
    test "returns error for forbidden api access" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 5 ->
        {:ok, %HTTPoison.Response{status_code: 403}}
      end)

      assert {:error, :forbidden} = Summoner.get_match_ids("test_puuid", "NA1")
    end

    test "returns error for summoner not found" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 5 ->
        {:ok, %HTTPoison.Response{status_code: 404}}
      end)

      assert {:error, :match_ids_not_found} = Summoner.get_match_ids("test_puuid", "NA1")
    end

    test "returns error for api rate limit exceeded" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 5 ->
        {:ok, %HTTPoison.Response{status_code: 429}}
      end)

      assert {:error, :rate_limit_exceeded} = Summoner.get_match_ids("test_puuid", "NA1")
    end

    test "parses match ids if valid response given puuid, defaults to batch size 5" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 5 ->
        {:ok,
         %HTTPoison.Response{
           body: "[\"NA1_test_1\",\"NA1_test_2\",\"NA1_test_3\",\"NA1_test_4\",\"NA1_test_5\"]"
         }}
      end)

      assert {:ok, ["NA1_test_1", "NA1_test_2", "NA1_test_3", "NA1_test_4", "NA1_test_5"]} =
               Summoner.get_match_ids("test_puuid", "NA1")
    end

    test "parses match ids if valid response given summoner, defaults to batch size 5" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 5 ->
        {:ok,
         %HTTPoison.Response{
           body: "[\"NA1_test_1\",\"NA1_test_2\",\"NA1_test_3\",\"NA1_test_4\",\"NA1_test_5\"]"
         }}
      end)

      assert {:ok, ["NA1_test_1", "NA1_test_2", "NA1_test_3", "NA1_test_4", "NA1_test_5"]} =
               Summoner.get_match_ids(@summoner, "NA1")
    end

    test "batch size can be input" do
      expect(MockRiotClient, :get_match_ids, fn "test_puuid", "NA1", 1 ->
        {:ok,
         %HTTPoison.Response{
           body: "[\"NA1_test_1\"]"
         }}
      end)

      assert {:ok, ["NA1_test_1"]} = Summoner.get_match_ids(@summoner, "NA1", 1)
    end
  end

  describe "get_name/1" do
    test "returns summoner name from summoner struct" do
      assert "test_summoner" = Summoner.get_name(@summoner)
    end

    test "returns nil when input is not a summoner struct" do
      assert nil == Summoner.get_name(nil)
    end
  end
end
