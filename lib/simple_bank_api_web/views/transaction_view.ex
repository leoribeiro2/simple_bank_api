defmodule SimpleBankApiWeb.TransactionView do
  use SimpleBankApiWeb, :view
  alias SimpleBankApiWeb.TransactionView

  def render("index.json", %{transations: transations}) do
    %{data: render_many(transations, TransactionView, "transaction.json")}
  end

  def render("transfer.json", %{to_name: to_name, amount: amount}) do
    %{
      sucess: true,
      message: "Transfer of #{amount} to #{to_name} performed successfully"
    }
  end

  def render("transactions.json", %{balance: balance, transactions: transactions}) do
    %{
      balance: balance,
      transations: render_many(transactions, TransactionView, "transaction.json")
    }
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      history: transaction.history,
      date: transaction.date,
      amount: transaction.amount}
  end
end
