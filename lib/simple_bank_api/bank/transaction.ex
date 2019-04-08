defmodule SimpleBankApi.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transations" do
    field :amount, :decimal
    field :date, :date
    field :history, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:user_id, :history, :date, :amount])
    |> validate_required([:user_id, :history, :date, :amount])
  end
end
