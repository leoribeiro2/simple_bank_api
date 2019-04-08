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

  def render("transaction.json", %{transaction: transaction}, account) do
    %{id: transaction.id,
      account: account,
      history: transaction.history,
      date: transaction.date,
      amount: transaction.amount}
  end
end
