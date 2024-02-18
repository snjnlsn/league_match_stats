import React, { useState } from "react"
import MatchHistory from "./match_history"

const Profile = (_) => {
  const [currentMatches, setCurrentMatches] = useState([])
  const [remainingMatchIDs, setRemainingMatchIDs] = useState([])
  const [summoner, setSummoner] = useState(null)
  const [loading, setLoading] = useState(false)
  const [input, setInput] = useState("")

  const getData = (name) => {
    setCurrentMatches([])
    setSummoner(null)
    setLoading(true)

    fetch(`/api/summoner?name=${encodeURI(name)}`, { method: "GET" })
      .then((res) => res.json())
      .then(({ matches, remaining_match_ids, summoner }) => {
        setLoading(false)
        setCurrentMatches(matches)
        setRemainingMatchIDs(remaining_match_ids)
        setSummoner(summoner)
      })
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    setInput("")
    getData(input)
  }

  const handlePaginate = () => {
    fetch("/api/matches", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ matches: remainingMatchIDs, puuid }),
    })
      .then((res) => res.json())
      .then(({ matches, remaining_match_ids }) => {
        setCurrentMatches([...currentMatches, ...matches])
        setRemainingMatchIDs(remaining_match_ids)
      })
  }

  const handleChange = (value) => {
    setInput(value)
  }

  return (
    <>
      <div className="bg-zinc-900 p-4 m-4">
        <form
          action="/api/summoner"
          method="get"
          onSubmit={(e) => handleSubmit(e)}
          className="grid grid-cols-search"
        >
          <input
            id="header-search"
            placeholder="Summoner"
            className="bg-zinc-700"
            value={input}
            name="name"
            onChange={(e) => handleChange(e.target.value)}
          />
          <button
            className="text-zinc-100 bg-zinc-500 hover:bg-zinc-400"
            type="submit"
          >
            Search
          </button>
        </form>
      </div>
      {summoner && (
        <div className="phx-hero bg-zinc-900 grid sm:grid-rows-2 md:grid-rows-1 gap-x-4 grid-cols-2 md:grid-cols-5 m-4 p-4 md:justify-items-center items-center">
          <div id="summoner-icon" className="md:w-20 row-span-2">
            <img
              className="md:max-h-[80px] md:max-w-[80px] size-[120px]"
              src={`https://ddragon.leagueoflegends.com/cdn/14.3.1/img/profileicon/${summoner.icon_uri}.png`}
            />
          </div>
          <div id="name" className="text-zinc-100">
            Summoner: {summoner.name}
          </div>
          <div id="level" className="text-zinc-100">
            Level: {summoner.level}
          </div>
        </div>
      )}
      <MatchHistory
        matches={currentMatches}
        loading={loading}
        handlePaginate={remainingMatchIDs.length > 0 ? handlePaginate : null}
      />
    </>
  )
}

export default Profile
