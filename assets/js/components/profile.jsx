import React, { useState, useEffect } from "react"
import MatchHistory from "./match_history"

const Profile = (_) => {
  const [currentMatches, setCurrentMatches] = useState([])
  const [remainingMatchIDs, setRemainingMatchIDs] = useState([])
  const [puuid, setPuuid] = useState("")
  const [loading, setLoading] = useState(false)
  const [input, setInput] = useState("")

  useEffect(() => {
    getData("katevolved")
  }, [])

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
      <div>
        <form
          action="/api/summoner"
          method="get"
          onSubmit={(e) => handleSubmit(e)}
        >
          <label htmlFor="header-search">
            <span className="visually-hidden">Search Summoner</span>
          </label>
          <input
            id="header-search"
            placeholder="Summoner"
            value={input}
            name="name"
            onChange={(e) => handleChange(e.target.value)}
          />
          <button type="submit">Search</button>
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
