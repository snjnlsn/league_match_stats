# LeagueMatchStats

- This application requires Elixir, Erlang, and Node to be installed. If you use ASDF, you simply run `asdf install`
- Run `mix setup` to install and setup dependencies
- Create a `config/.env` and add `RIOT_API_KEY=YOUR_KEY_HERE` to it. [`Get a Developer API key here`](https://developer.riotgames.com/docs/portal#web-apis_api-keys)
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Region/Platform

- Region and Platform default to `NA2` and `Americas` accordingly. These values can be adjusted in `config/config.exs`.
