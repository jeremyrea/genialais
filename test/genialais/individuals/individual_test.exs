defmodule Genialais.Individuals.IndividualTest do
  use Genialais.DataCase

  alias Genialais.Individuals.Individual

  test "changeset/2 sets gender" do
    individual =
      %Individual{}
      |> Individual.changeset(%{gender: :male})
      |> Ecto.Changeset.apply_changes()

    assert individual.gender == :male
  end

  test "changeset/2 changes gender" do
    individual =
      %Individual{gender: :male}
      |> Individual.changeset(%{gender: :female})
      |> Ecto.Changeset.apply_changes()

    assert individual.gender == :female
  end

  test "changeset/2 rejects invalid gender" do
    changeset = Individual.changeset(%Individual{}, %{gender: :ghost})
    assert elem(changeset.errors[:gender], 0) == "is invalid"
    assert elem(changeset.errors[:gender], 1)[:validation] == :cast
  end

  test "changeset/2 with name parts is applied" do
    name_parts = %{givenName: "Bobby", surname: "Droptables"}
    
    individual =
      %Individual{}
      |> Individual.changeset(%{gender: :male, name_parts: name_parts})
      |> Ecto.Changeset.apply_changes()

    assert individual.name_parts.givenName == "Bobby"
    assert individual.name_parts.surname == "Droptables"
  end
end