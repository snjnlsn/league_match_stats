import React from "react"
import {
 Routes,
 Route,
 useNavigate
} from "react-router-dom"
import MatchHistory from "./components/match_history"
import Profile from "./components/profile"

const App = (props) => {
const navigate = useNavigate()
const handleProfileClick = () => {
 navigate('/profile')
}
const handleMatchHistoryClick = () => {
  navigate('/match_history')
}

  return (
    <Routes>
      <Route path="/" element={
        <>
        <button onClick={handleProfileClick}>Profile Summary</button>
        <button onClick={handleMatchHistoryClick}>Match History</button>
        </>
      } />

      <Route path="/profile" element={<Profile />}/>
      <Route path="/match_history" element={<MatchHistory/>}/>
    </Routes>
  )
}

export default App
