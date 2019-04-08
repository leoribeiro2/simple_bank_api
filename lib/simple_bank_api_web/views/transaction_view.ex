defmodule SimpleBankApiWeb.TransactionView do
  use SimpleBankApiWeb, :view
  alias SimpleBankApiWeb.TransactionView

  def render("index.json", %{transations: transations}) do
    %{data: render_many(transations, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}, account) do
    %{id: transaction.id,
      account: account,
      history: transaction.history,
      date: transaction.date,
      amount: transaction.amount}
  end
end
