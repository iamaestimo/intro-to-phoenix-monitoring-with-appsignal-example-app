defmodule CounterLiveApp.Repo do
  use Ecto.Repo,
    otp_app: :counter_live_app,
    adapter: Ecto.Adapters.Postgres
end
