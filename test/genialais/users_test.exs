defmodule Genialais.UsersTest do
  use Genialais.DataCase

  alias Genialais.{Repo, Users, Users.User}

  @valid_params %{email: "test@example.com", password: "secret1234", password_confirmation: "secret1234"}

  test "create_user/2" do
    assert {:ok, user} = Users.create_user(@valid_params)
    assert user.role == "visitor"
  end

  test "set_role/1" do
    assert {:ok, user} = Repo.insert(User.changeset(%User{}, @valid_params))
    assert user.role == "visitor"

    assert {:ok, user} = Users.set_role(user, "admin")
    assert user.role == "admin"
  end

  test "is_admin?/1" do
    refute Users.is_admin?(nil)
  
    assert {:ok, user} = Repo.insert(User.changeset(%User{}, @valid_params))
    refute Users.is_admin?(user)
  
    assert {:ok, user2} = Users.create_user(%{@valid_params | email: "test2@example.com"})
    assert {:ok, admin} = Users.set_role(user2, "admin")
    assert Users.is_admin?(admin)
  end

  test "delete_user?/1" do
    assert {:ok, user} = Users.create_user(@valid_params)
    assert user = Users.get_user(user.id)
    
    assert {:ok, user} = Users.delete_user(user.id)

    refute Users.get_user(user.id)
  end
end