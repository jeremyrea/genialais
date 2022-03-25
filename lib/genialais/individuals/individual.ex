defmodule Genialais.Individuals.Individual do
  use Ecto.Schema
  import Ecto.Changeset

  alias Genialais.Individuals.NameParts

  schema "individuals" do
    field :gender, Ecto.Enum, values: [:male, :female, :unknown]
    has_one :name_parts, NameParts

    timestamps()
  end

  @spec changeset(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset(individual_or_changeset, attrs \\ {}) do
    individual_or_changeset
    |> Ecto.Changeset.cast(attrs, [:gender])
    |> Ecto.Changeset.cast_assoc(:name_parts)
    |> validate_required([:gender])
    |> Ecto.Changeset.validate_inclusion(:gender, [:male, :female, :unknown])
  end
end
