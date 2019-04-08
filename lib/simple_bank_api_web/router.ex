defmodule SimpleBankApiWeb.Router do
  use SimpleBankApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", SimpleBankApiWeb do
    pipe_through :api

    post "/sign_up", UserController, :create
  end
end
