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
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end
end
