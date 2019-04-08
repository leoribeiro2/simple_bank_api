defmodule SimpleBankApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :account, :string
    field :email, :string
    field :name, :string
    field :password_hash, :string
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :account, :password, :password_confirmation])
    |> validate_required([:email, :name, :password, :password_confirmation])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    # Check that password length is >= 8
    |> validate_length(:password, min: 8)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    # Add put_password_hash to changeset pipeline
    |> put_password_hash
    |> create_account
  end

  defp create_account(changeset) do
    case changeset do
       %Ecto.Changeset{valid?: true} ->
         put_change(changeset, :account, to_string(Integer.to_string(:rand.uniform(:os.system_time(:millisecond)), 32)))
       _ ->
        changeset
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
