defmodule SimpleBankApi.AccountsTest do
  use SimpleBankApi.DataCase

  alias SimpleBankApi.Accounts

  describe "users" do
    alias SimpleBankApi.Accounts.User

    @valid_attrs %{account: "some account", email: "foo5@bar.com", name: "some name", password: "somePassword", password_confirmation: "somePassword"}
    @invalid_attrs %{email: nil, name: nil, password: nil, password_confirmation: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert user.email == "foo5@bar.com"
      assert user.name == "some name"
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert user.email == "foo5@bar.com"
      assert user.name == "some name"
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "foo5@bar.com"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
