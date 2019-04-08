defmodule SimpleBankApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias SimpleBankApi.Repo

  alias SimpleBankApi.Accounts.User

  alias SimpleBankApi.Guardian
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [
        %SimpleBankApi.Accounts.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          account: "51VO9EIR",
          email: "foo@bar.com",
          id: 1,
          inserted_at: ~N[2019-04-08 16:05:57],
          name: "foo",
          password: nil,
          password_confirmation: nil,
          password_hash: "$2b$12$XVyeEe.jaXFpHOaADi.kn.Tj2BKAhTZHTy6hVAIGTLuMrQfHksy/G",
          updated_at: ~N[2019-04-08 16:05:57]
        }
      ]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(1)
      %SimpleBankApi.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        account: "51VO9EIR",
        email: "foo@bar.com",
        id: 1,
        inserted_at: ~N[2019-04-08 16:05:57],
        name: "foo",
        password: nil,
        password_confirmation: nil,
        password_hash: "$2b$12$XVyeEe.jaXFpHOaADi.kn.Tj2BKAhTZHTy6hVAIGTLuMrQfHksy/G",
        updated_at: ~N[2019-04-08 16:05:57]
      }

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> SimpleBankApi.Accounts.create_user(%{name: "foo", email: "foo@bar.com", password: "somePassword", password_confirmation: "somePassword"})
      {:ok,
     %SimpleBankApi.Accounts.User{
       __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
       account: "51VO9EIR",
       email: "foo@bar.com",
       id: 12,
       inserted_at: ~N[2019-04-08 16:05:57],
       name: "foo",
       password: "somePassword",
       password_confirmation: "somePassword",
       password_hash: "$2b$12$XVyeEe.jaXFpHOaADi.kn.Tj2BKAhTZHTy6hVAIGTLuMrQfHksy/G",
       updated_at: ~N[2019-04-08 16:05:57]
     }}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Sign in token a user using email and password.

  ## Examples

     iex> SimpleBankApi.Accounts.token_sign_in("foo@bar.com", "somePassword")
     {:ok,
     "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJTaW1wbGVCYW5rQXBpIiwiZXhwIjoxNTU3MTU4MjU3LCJpYXQiOjE1NTQ3MzkwNTcsImlzcyI6IlNpbXBsZUJhbmtBcGkiLCJqdGkiOiJhZWE3ODUxYy00YjM0LTQxNTEtYjJlMi02MWJiYTM5OWM1ZjkiLCJuYmYiOjE1NTQ3MzkwNTYsInN1YiI6IjEiLCJ0eXAiOiJhY2Nlc3MifQ.mZaM3Nt7mpCPaqk_AdVGMaQ1_1ZarxEz4FOVcUopk5aqzJSQL_8YKOtcap79HRF05vOWbm0eYwtIEcUTHx5WGA",
     %{
       "aud" => "SimpleBankApi",
       "exp" => 1557158257,
       "iat" => 1554739057,
       "iss" => "SimpleBankApi",
       "jti" => "aea7851c-4b34-4151-b2e2-61bba399c5f9",
       "nbf" => 1554739056,
       "sub" => "1",
       "typ" => "access"
     }}

  """
  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  @doc """
  Sign in user using email and password.

  ## Examples

     iex> SimpleBankApi.Accounts.email_password_auth("foo@bar.com", "somePassword")
     {:ok,
     %SimpleBankApi.Accounts.User{
       __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
       account: nil,
       email: "foo@bar.com",
       id: 1,
       inserted_at: ~N[2019-04-08 14:15:18],
       name: "foo",
       password: nil,
       password_confirmation: nil,
       password_hash: "$2b$12$VnPubXY3mrO0X1eW4O.hCuKdt6Xw5VBvL3G3afn1yj25xxOYU0OQ6",
       updated_at: ~N[2019-04-08 14:15:18]
     }}

  """
  def email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  def get_by_account(account) do
    case Repo.get_by(User, account: account) do
      nil ->
        {:error, "Not Found"}
      user ->
        user
    end
  end
end
