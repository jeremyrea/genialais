defmodule Genialais.Individuals.Individual do
  use Ecto.Schema
  import Ecto.Changeset

  schema "individuals" do
    field :gender, Ecto.Enum, values: [:male, :female, :unknown]

    timestamps()
  end

  @spec changeset_gender(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_gender(individual_or_changeset, attrs) do
    individual_or_changeset
    |> Ecto.Changeset.cast(attrs, [:gender])
    |> Ecto.Changeset.validate_inclusion(:gender, [:male, :female, :unknown])
  end
end
