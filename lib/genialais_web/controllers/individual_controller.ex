defmodule GenialaisWeb.IndividualController do
  use GenialaisWeb, :controller

  alias Genialais.Repo
  alias Genialais.Individuals
  alias Genialais.Individuals.Individual
  alias Genialais.Individuals.NameParts
  alias Ecto


  def index(conn, params) do
    render(conn, "index.html", data: list_individuals(params))
  end

  def new(conn, _params) do
    changeset = Individual.changeset(%Individual{name_parts: %NameParts{}}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"individual" => individual}) do
    %Individual{}
    |> Individual.changeset(individual)
    |> Repo.insert()
    |> case do
      {:ok, _individual} ->
        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: Routes.individual_path(conn, :index)) # use new individual id to send to :show
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp list_individuals(params) do
    Individuals.list_individuals(params) 
    |> Enum.reject(fn x -> x.name_parts == nil end) ## Temporary
    |> Enum.map(fn x -> %{givenName: x.name_parts.givenName, gender: x.gender} end)
  end
end
