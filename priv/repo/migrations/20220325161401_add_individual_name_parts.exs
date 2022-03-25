defmodule Genialais.Repo.Migrations.AddIndividualNameParts do
  use Ecto.Migration

  def change do
    create table("individual_name_parts") do
      add :individual_id, references(:individuals)
      add :givenName, :string, null: false
      add :surname, :string, null: false
      add :surnamePrefix, :string, null: true
      add :prefix, :string, null: true
      add :suffix, :string, null: true
      add :nickname, :string, null: true

      timestamps()
    end
  end
end
