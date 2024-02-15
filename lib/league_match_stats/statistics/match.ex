defmodule LeagueMatchStats.Statistics.Match do
  alias LeagueMatchStats.Repo
  alias LeagueMatchStats.Statistics.Champion

  @derive {Jason.Encoder, except: [:timestamp]}
  defstruct [
    :assists,
    :champion,
    :deaths,
    :game_length,
    :game_mode,
    :game_start,
    :gold_earned,
    :kda,
    :kills,
    :outcome,
    :timestamp,
    :vision_score
  ]

  def process_match_response(body, puuid) do
    participant = get_participant(body, puuid)

    champion =
      Repo.get_by(Champion, external_id: Integer.to_string(participant["championId"]))

    game_length = get_game_length(body)
    game_start = format_game_start(body["gameStartTimestamp"])
    kda = calculate_kda(participant)

    {:ok,
     %__MODULE__{
       assists: participant["assists"],
       champion: champion,
       deaths: participant["deaths"],
       game_start: game_start,
       game_length: game_length,
       game_mode: body["gameMode"],
       gold_earned: participant["goldEarned"],
       kda: kda,
       kills: participant["kills"],
       outcome: participant["win"],
       vision_score: participant["visionScore"]
     }}
  end

  defp get_game_length(%{"gameEndTimestamp" => _, "gameDuration" => duration_in_seconds}) do
    with duration <- Timex.Duration.from_seconds(duration_in_seconds),
         {:ok, time} <- Timex.Duration.to_time(duration),
         {:ok, formatted_time} <- Timex.format(time, "%T", :strftime),
         trimmed_string <- trim_time(formatted_time) do
      trimmed_string
    end
  end

  defp get_game_length(%{"gameDuration" => duration_in_milliseconds}) do
    with duration <-
           Timex.Duration.from_milliseconds(duration_in_milliseconds),
         {:ok, time} <- Timex.Duration.to_time(duration),
         {:ok, formatted_time} <- Timex.format(time, "%T", :strftime),
         trimmed_string <- trim_time(formatted_time) do
      trimmed_string
    end
  end

  defp trim_time("00:" <> time), do: time
  defp trim_time(time), do: time

  defp calculate_kda(%{"deaths" => "0"}), do: "infinity"

  defp calculate_kda(%{"assists" => assists, "deaths" => deaths, "kills" => kills}),
    do: ((assists + deaths) / kills) |> Float.to_string()

  defp format_game_start(unix_timestamp) do
    {:ok, time} =
      Timex.from_unix(unix_timestamp, :millisecond)
      |> Timex.format("%I:%M%p, %m/%d/%Y", :strftime)

    time
  end

  defp get_participant(%{"participants" => participants}, puuid),
    do: Enum.find(participants, &(&1["puuid"] == puuid))
end
