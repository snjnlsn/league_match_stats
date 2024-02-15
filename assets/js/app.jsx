import React from "react"
import {
 Routes,
 Route,
 useNavigate
} from "react-router-dom"
import Profile from "./components/profile"

const App = (_props) => {
const navigate = useNavigate()
const handleProfileClick = () => {
 navigate('/profile')
}

  return (
    <Routes>
      <Route path="/*" element={
        <>
        <button onClick={handleProfileClick}>Profile Summary</button>
        </>
      } />

      <Route path="/profile" element={<Profile />}/>
    </Routes>
  )
}

export default App
