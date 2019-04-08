defmodule SimpleBankApi.Repo.Migrations.CreateTransations do
  use Ecto.Migration

  def change do
    create table(:transations) do
      add :user_id, :integer
      add :history, :string
      add :date, :date
      add :amount, :decimal

      timestamps()
    end

  end
end
