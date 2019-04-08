defmodule SimpleBankApiWeb.UserView do
  use SimpleBankApiWeb, :view
  alias SimpleBankApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email,
      name: user.name,
      account: user.account}
  end
end
