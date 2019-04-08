defmodule SimpleBankApiWeb.TransactionController do
  use SimpleBankApiWeb, :controller

  alias SimpleBankApi.Bank
  alias SimpleBankApi.Bank.Transaction

  action_fallback SimpleBankApiWeb.FallbackController

  def index(conn, _params) do
    transations = Bank.list_transations()
    render(conn, "index.json", transations: transations)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Bank.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Bank.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end
end
