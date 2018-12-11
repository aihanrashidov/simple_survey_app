defmodule Easysurveys.Repo do
  use Ecto.Repo,
    otp_app: :easysurveys,
    adapter: Ecto.Adapters.Postgres
end
