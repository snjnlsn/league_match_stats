defmodule LeagueMatchStats.Statistics.Client do
  # API Docs: https://developer.riotgames.com/apis#summoner-v4/GET_getBySummonerName
  def fetch_summoner(name) do
    with {:ok, resp} <-
           Req.get(base_request(:platform), url: "/lol/summoner/v4/summoners/by-name/#{name}"),
         body <- Map.get(resp, :body) do
      {:ok, body}
    else
      _ -> {:error, "could not fetch summoner"}
    end
  end

  # API Docs: https://developer.riotgames.com/apis#match-v5/fetch_getMatchIdsByPUUID
  def fetch_match_ids(puuid) do
    with {:ok, resp} <-
           Req.get(base_request(:region), url: "/lol/match/v5/matches/by-puuid/#{puuid}/ids"),
         body <- Map.get(resp, :body) do
      {:ok, body}
    else
      _ -> {:error, "could not fetch matches"}
    end
  end

  # API Docs: https://developer.riotgames.com/apis#match-v5/GET_getMatch
  def fetch_match(id) do
    with {:ok, %{status: 200} = resp} <-
           Req.get(base_request(:region), url: "/lol/match/v5/matches/#{id}"),
         body <- Map.get(resp, :body) do
      {:ok, body["info"]}
    else
      _ -> {:error, "could not fetch match"}
    end
  end

  # Ideally make these region/locality dependent based off list in config & curr location - unsure wehther locality info is provided by elixir processes or requires config for local & cloud
  defp base_request(:platform) do
    Req.new(
      base_url: "https://#{config(:platform)}.#{config(:base_url)}",
      headers: [{"X-Riot-Token", config(:api_key)}]
    )
  end

  defp base_request(:region) do
    Req.new(
      base_url: "https://#{config(:region)}.#{config(:base_url)}",
      headers: [{"X-Riot-Token", config(:api_key)}]
    )
  end

  defp config(key) do
    Application.get_env(:league_match_stats, __MODULE__)[key]
  end
end
