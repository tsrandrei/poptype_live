defmodule PoptypeLive.Repo do
  use Ecto.Repo,
    otp_app: :poptype_live,
    adapter: Ecto.Adapters.Postgres
end
