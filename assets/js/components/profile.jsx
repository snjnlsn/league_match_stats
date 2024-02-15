import React, { useState, useEffect } from "react"
import MatchHistory from "./match_history"

const Profile = (_) => {
  const [currentMatches, setCurrentMatches] = useState([])
  const [remainingMatchIDs, setRemainingMatchIDs] = useState([])
  const [puuid, setPuuid] = useState("")
  const [loading, setLoading] = useState(false)
  const [input, setInput] = useState("")

  const getData = (name) => {
    setCurrentMatches([])
    setLoading(true)

    fetch(`/api/summoner?name=${encodeURI(name)}`, { method: "GET" })
      .then((res) => res.json())
      .then(({ matches, remaining_match_ids, puuid }) => {
        setLoading(false)
        setCurrentMatches(matches)
        setRemainingMatchIDs(remaining_match_ids)
        setPuuid(puuid)
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
      <MatchHistory
        matches={currentMatches}
        loading={loading}
        handlePaginate={remainingMatchIDs.length > 0 ? handlePaginate : null}
      />
    </>
  )
}

export default Profile
