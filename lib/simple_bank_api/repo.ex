defmodule SimpleBankApi.Repo do
  use Ecto.Repo,
    otp_app: :simple_bank_api,
    adapter: Ecto.Adapters.Postgres
end
