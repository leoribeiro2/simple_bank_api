defmodule SimpleBankApiWeb.TransactionController do
  use SimpleBankApiWeb, :controller

  alias SimpleBankApi.Bank
  ## alias SimpleBankApi.Bank.Transaction
  alias SimpleBankApi.Guardian
  alias SimpleBankApi.Accounts

  action_fallback SimpleBankApiWeb.FallbackController

  def index(conn, _params) do
    transations = Bank.list_transations()
    render(conn, "index.json", transations: transations)
  end

  def transfer(conn, %{"to" => to, "amount" => amount}) do
    case Bank.transfer(%{
      from_user: Guardian.Plug.current_resource(conn),
      to_user: Accounts.get_by_account(to),
      amount: amount
    }) do
      {:ok, transfer} ->
        conn
        |> put_status(:created)
        |> render("transfer.json", transfer)
      {:error, reason} ->
        {:error, :bad_request, reason: reason}
      end
  end

  def show(conn, %{"id" => id}) do
    transaction = Bank.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end
end
