import React, { useEffect, useState } from "react"
// import { useSearchParams } from "react-router-dom"

const MatchHistory = ({ matches, handlePaginate, loading }) => {
  if (loading) {
    return (
      <div className="phx-hero bg-zinc-900 grid m-4 p-4 justify-items-center items-center">
        <div className="text-zinc-100">loading...</div>
      </div>
    )
  }

  return matches.length === 0 ? (
    <div className="phx-hero bg-zinc-900 grid m-4 p-4 justify-items-center items-center">
      <div className="text-zinc-100">Search by Summoner name!</div>
    </div>
  ) : (
    <>
      <div>
        {matches.map(
          (
            {
              champion,
              outcome,
              kda,
              kills,
              deaths,
              assists,
              vision_score,
              game_mode,
              // game_start,
              game_length,
              gold_earned,
            },
            id
          ) => {
            return (
              <div
                key={id}
                className="phx-hero bg-zinc-900 grid sm:grid-rows-5 md:grid-rows-2 grid-cols-2 md:grid-cols-5 gap-4 m-4 p-4 justify-items-center items-center"
              >
                <div id="champion-photo" className="md:w-20 row-span-5">
                  <img
                    src={`https://ddragon.leagueoflegends.com/cdn/14.3.1/img/champion/${champion["image_uri"]}`}
                  />
                </div>
                <div id="outcome" className="text-zinc-100 md:col-span-4">
                  {outcome ? "Won" : "Lost"} as {champion["name"]},{" "}
                  {game_length}
                </div>
                <div id="kda" className="text-zinc-100">
                  KDA: {`${kda}: ${kills} / ${deaths} / ${assists}`}
                </div>
                <div id="vis-score" className="text-zinc-100">
                  Vision: {vision_score}
                </div>
                <div id="gold" className="text-zinc-100">
                  Gold: {gold_earned}
                </div>
                <div id="game-mode" className="text-zinc-100">
                  Game Mode: {game_mode}
                </div>
              </div>
            )
          }
        )}
        {handlePaginate && <button onClick={handlePaginate}>Paginate</button>}
      </div>
    </>
  )
}

export default MatchHistory
