defmodule SimpleBankApi.BankTest do
  use SimpleBankApi.DataCase

  alias SimpleBankApi.Bank

  describe "transations" do
    alias SimpleBankApi.Bank.Transaction

    @valid_attrs %{amount: "120.5", date: ~D[2010-04-17], history: "some history", user_id: 42}
    @invalid_attrs %{amount: nil, date: nil, history: nil, user_id: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bank.create_transaction()

      transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Bank.create_transaction(@valid_attrs)
      assert transaction.amount == Decimal.new("120.5")
      assert transaction.date == ~D[2010-04-17]
      assert transaction.history == "some history"
      assert transaction.user_id == 42
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bank.create_transaction(@invalid_attrs)
    end
  end
end
