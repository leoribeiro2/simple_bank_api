defmodule SimpleBankApi.Bank do
  @moduledoc """
  The Bank context.
  """

  import Ecto.Query, warn: false
  alias SimpleBankApi.Repo

  alias SimpleBankApi.Bank.Transaction

  @doc """
  Returns the list of transations.

  ## Examples

      iex> list_transations()
      [%Transaction{}, ...]

  """
  def list_transations do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  def get_balance(user_id) do
    query = from t in Transaction, where: t.user_id == ^user_id, select: sum(t.amount)
    case Repo.one(query) do
      nil ->
        0
      balance ->
        balance
    end
  end

  def transfer(%{from_user: from_user, to_user: to_user, amount: amount}) do
    balance = get_balance(from_user.id)
    if balance >= amount do
      create_transaction(%{
        user_id: from_user.id,
        history: "transfer to #{to_user.name}",
        date: DateTime.utc_now,
        amount: -amount
      })
      create_transaction(%{
        user_id: to_user.id,
        history: "transfer from #{from_user.name}",
        date: DateTime.utc_now,
        amount: amount
      })
      {:ok, %{to_name: to_user.name, amount: amount}}
    else
      {:error, "Not have funds"}
    end
  end
end
