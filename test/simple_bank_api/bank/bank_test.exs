defmodule SimpleBankApi.BankTest do
  use SimpleBankApi.DataCase

  alias SimpleBankApi.Bank

  describe "transations" do
    alias SimpleBankApi.Bank.Transaction

    @valid_attrs %{amount: "120.5", date: ~D[2010-04-17], history: "some history", user_id: 42}
<<<<<<< HEAD
=======
    @update_attrs %{amount: "456.7", date: ~D[2011-05-18], history: "some updated history", user_id: 43}
>>>>>>> 8ff8865fe23f808418ff44c1d63c1a4c64fc02e3
    @invalid_attrs %{amount: nil, date: nil, history: nil, user_id: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bank.create_transaction()

      transaction
    end

<<<<<<< HEAD
=======
    test "list_transations/0 returns all transations" do
      transaction = transaction_fixture()
      assert Bank.list_transations() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Bank.get_transaction!(transaction.id) == transaction
    end

>>>>>>> 8ff8865fe23f808418ff44c1d63c1a4c64fc02e3
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
<<<<<<< HEAD
=======

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Bank.update_transaction(transaction, @update_attrs)
      assert transaction.amount == Decimal.new("456.7")
      assert transaction.date == ~D[2011-05-18]
      assert transaction.history == "some updated history"
      assert transaction.user_id == 43
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Bank.update_transaction(transaction, @invalid_attrs)
      assert transaction == Bank.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Bank.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Bank.change_transaction(transaction)
    end
>>>>>>> 8ff8865fe23f808418ff44c1d63c1a4c64fc02e3
  end
end
