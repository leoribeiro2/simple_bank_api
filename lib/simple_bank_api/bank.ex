defmodule SimpleBankApi.Bank do
  @moduledoc """
  The Bank context.
  """

  import Ecto.Query, warn: false
  alias SimpleBankApi.Repo

  alias SimpleBankApi.Bank.Transaction
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

  def get_transactions_by_user_id(user_id) do
    query = from t in Transaction, where: t.user_id == ^user_id
    case Repo.all(query) do
      nil ->
        {:error, "Not Found"}
      transations ->
        transations
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
      send_transaction_email(from_user)
      {:ok, %{to_name: to_user.name, amount: amount}}
    else
      {:error, "Not have funds"}
    end
  end

  defp send_transaction_email(user) do
    # TODO: implments send mail here
  end

  def totals do
    now = NaiveDateTime.utc_now
    total_day_query = from t in Transaction, where: t.date == ^now, select: sum(t.amount)
    total_day = Repo.one(total_day_query)
    total_month_query = from t in Transaction, where: t.date > ^%Date{day: 1, month: now.month, year: now.year}, select: sum(t.amount)
    total_month = Repo.one(total_month_query)
    total_year_query = from t in Transaction, where: t.date > ^%Date{day: 1, month: 1, year: now.year}, select: sum(t.amount)
    total_year = Repo.one(total_year_query)
    grand_total_query = from t in Transaction, select: sum(t.amount)
    grand_total = Repo.one(grand_total_query)
    %{total_day: total_day, total_month: total_month, total_year: total_year, grand_total: grand_total}
  end
end
