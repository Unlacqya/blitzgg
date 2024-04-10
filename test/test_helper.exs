ExUnit.start()

Mox.defmock(Blitzgg.Riot.MockRiotClient, for: Blitzgg.Riot.RiotClient)

Application.put_env(:blitzgg, :riot_client, Blitzgg.Riot.MockRiotClient)
