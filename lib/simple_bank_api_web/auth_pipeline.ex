defmodule SimpleBankApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :simple_bank_api,
  module: SimpleBankApi.Guardian,
  error_handler: SimpleBankApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
