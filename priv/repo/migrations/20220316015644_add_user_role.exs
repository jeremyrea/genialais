defmodule Genialais.Repo.Migrations.AddUserRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, null: false, default: "visitor"
    end
  end
end
