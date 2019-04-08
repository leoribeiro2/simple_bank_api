defmodule SimpleBankApiWeb.UserController do
  use SimpleBankApiWeb, :controller

  alias SimpleBankApi.Accounts
  alias SimpleBankApi.Accounts.User
  alias SimpleBankApi.Guardian

  action_fallback SimpleBankApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
     user = Guardian.Plug.current_resource(conn)
     conn |> render("user.json", user: user)
  end
end
