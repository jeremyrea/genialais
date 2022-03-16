defmodule Genialais.Users do
  alias Genialais.{Repo, Users.User}

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec create_editor(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_editor(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "editor"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  @spec set_editor_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_editor_role(user) do
    user
    |> User.changeset_role(%{role: "editor"})
    |> Repo.update()
  end

  @spec is_admin?(t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false
end