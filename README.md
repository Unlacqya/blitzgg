# Blitzgg

This project takes input from the command line for a summoner name and region and then executes queries to the Riot API
in order to fetch all summonrs this person has played with in their last 5 games.  This is posted as a list to the CLI.  
It then watches all of those summoners, making calls to the Riot API every minute for one hour, posting to the CLI if a 
player has finished a new game in the format: "Summoner <summoner name> completed match <match id>".

## Test Coverage
We are at 67.44% Test Coverage.  We have full coverage on all files except for Worker, which is difficult to write unit tests for
due to the pipeline, and RiotClient, which is simply a module to house the urls for get requests to the Riot API and is Mocked in all tests using Mox.

## Running the Script
In order to run this project, enter the root directory of the project and run the following commands:
```elixir
iex -S mix
Blitzgg.Riot.LoL.Worker.run()
```

You will then be prompted for a summoner name and a region in order to kick off the watcher.

# Riot Development API
This project makes heavy use of the riot development API, which is documented here:
https://developer.riotgames.com/

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `blitzgg` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:blitzgg, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/blitzgg>.

