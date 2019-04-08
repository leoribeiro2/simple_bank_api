defmodule SimpleBankApiWeb.UserControllerTest do
  use SimpleBankApiWeb.ConnCase

  alias SimpleBankApi.Accounts

  @create_attrs %{
    email: "foo@bar.com",
    name: "some name",
    password: "somePassword",
    password_confirmation: "somePassword"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil, password_confirmation: nil}
  @valid_auth_attrs %{ email: "foo@bar.com", password: "somePassword"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "sign_up user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert json_response(conn, 201) != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "sign_in user" do
    test "authenticate user", %{conn: conn}  do
      fixture(:user)
      conn = post(conn, Routes.user_path(conn, :sign_in), @valid_auth_attrs)
      assert json_response(conn, 200) != %{}
      token = json_response(conn, 200)["token"]
      IO.puts(token)
    end

  end
end
