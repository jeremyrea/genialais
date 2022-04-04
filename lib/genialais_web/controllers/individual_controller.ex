defmodule GenialaisWeb.IndividualController do
  use GenialaisWeb, :controller

  alias Genialais.Repo
  alias Genialais.Individuals
  alias Genialais.Individuals.Individual
  alias Genialais.Individuals.NameParts
  alias Ecto


  def index(conn, params) do
    columns = view_module(conn).list_columns()
    rows = list_individuals(params)

    render(conn, "index.html", data: %{columns: columns, rows: rows})
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
    |> Enum.map(fn x -> %{
      givenName: x.name_parts.givenName, 
      surname: x.name_parts.surname,
      gender: x.gender
     } end)
  end
end
