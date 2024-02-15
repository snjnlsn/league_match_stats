import React, { useEffect, useState } from "react"
// import { useSearchParams } from "react-router-dom"

const MatchHistory = ({ matches, handlePaginate, loading }) => {
  if (loading) {
    return <div>loading</div>
  }

  return matches.length === 0 ? (
    <div></div>
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
              game_start,
              game_length,
              gold_earned,
            },
            id
          ) => {
            return (
              <div
                key={id}
                className="phx-hero border-2 border-black grid sm:grid-rows-5 md:grid-rows-2 grid-cols-2 md:grid-cols-5 gap-4 m-4 p-4 justify-items-center items-center"
              >
                <div id="champion-photo" className="md:w-20 row-span-5">
                  <img
                    src={`https://ddragon.leagueoflegends.com/cdn/14.3.1/img/champion/${champion["image_uri"]}`}
                  />
                </div>
                <div id="outcome" className="md:col-span-4">
                  {outcome ? "Won" : "Lost"} as {champion["name"]},{" "}
                  {game_length}
                </div>
                <div id="kda">
                  KDA: {`${kda}: ${kills} / ${deaths} / ${assists}`}
                </div>
                <div id="vis-score">Vision: {vision_score}</div>
                <div id="gold">Gold: {gold_earned}</div>
                <div id="game-mode">Game Mode: {game_mode}</div>
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
