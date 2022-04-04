defmodule Genialais.Individuals do
  alias Genialais.{Repo, Individuals.Individual}
  import Ecto.Query
  import GenialaisWeb.Components.DataTable, only: [sort: 1]

  alias Genialais.Individuals.NameParts

  @type t :: %Individual{}
  

  def list_individuals(params) do
    Individual
    |> select([i, n], [:id, :gender, n: [:givenName]])
    |> join(:left, [i], assoc(i, :name_parts), as: :name_parts) 
    |> order_by(^filter_order_by(sort(params)))
    |> preload([i, n], name_parts: n)
    |> Repo.all()
  end

  defp filter_order_by({order, "gender"}),
    do: [{order, dynamic([i], i.gender)}]

  defp filter_order_by({order, "name_parts.givenName"}),
    do: [{order, dynamic([name_parts: n], n.givenName)}]

  defp filter_order_by(_),
    do: []
end