defmodule Genialais.Users.UserTest do
  use Genialais.DataCase

  alias Genialais.Users.User

  test "changeset/2 sets default role" do
    user =
      %User{}
      |> User.changeset(%{})
      |> Ecto.Changeset.apply_changes()

    assert user.role == "visitor"
  end

  test "changeset_role/2" do
    changeset = User.changeset_role(%User{}, %{role: "invalid"})
    assert changeset.errors[:role] == {"is invalid", [validation: :inclusion, enum: ["visitor", "editor", "admin"]]}

    changeset = User.changeset_role(%User{}, %{role: "admin"})
    refute changeset.errors[:role]
  end
end