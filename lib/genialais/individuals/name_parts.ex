defmodule Genialais.Individuals.NameParts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "individual_name_parts" do
    belongs_to :individual, Genialais.Individuals.Individual

    field :givenName, :string, null: false
    field :surname, :string, null: false
    field :surnamePrefix, :string, null: true
    field :prefix, :string, null: true
    field :suffix, :string, null: true
    field :nickname, :string, null: true

    timestamps()
  end

@spec changeset(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset(individual_or_changeset, attrs \\ {}) do
    individual_or_changeset
    |> Ecto.Changeset.cast(attrs, [:givenName, :surname, :surnamePrefix, :prefix, :suffix, :nickname])
    |> validate_required([:givenName, :surname])
  end
end
