import React from "react"

const Hello = (props) => {
  const name = props.name

  return (
    <section className="phx-hero">
      <h1>Hey {name}, welcome to Phoenix + React :O</h1>
    </section>
  )
}

export default Hello
