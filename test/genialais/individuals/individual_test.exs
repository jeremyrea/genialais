defmodule Genialais.Individuals.IndividualTest do
  use Genialais.DataCase

  alias Genialais.Individuals.Individual

  test "changeset_gender/2 sets gender" do
    individual =
      %Individual{}
      |> Individual.changeset_gender(%{gender: :male})
      |> Ecto.Changeset.apply_changes()

    assert individual.gender == :male
  end

  test "changeset_gender/2 changes gender" do
    individual =
      %Individual{gender: :male}
      |> Individual.changeset_gender(%{gender: :female})
      |> Ecto.Changeset.apply_changes()

    assert individual.gender == :female
  end

  test "changeset_gender/2 rejects invalid gender" do
    changeset = Individual.changeset_gender(%Individual{}, %{gender: :ghost})
    assert elem(changeset.errors[:gender], 0) == "is invalid"
    assert elem(changeset.errors[:gender], 1)[:validation] == :cast
  end
end