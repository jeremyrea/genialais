defmodule Genialais.Repo.Migrations.AddIndividualsTable do
  use Ecto.Migration

  def up do
    create table("individuals") do
      add :gender, :string, size: 20

      timestamps()
    end
  end

  def down do
    drop table("individuals")
  end
end
