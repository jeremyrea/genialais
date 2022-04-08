defmodule Genialais.Individuals do
  alias Genialais.{Repo, Individuals.Individual}
  import Ecto.Query
  import GenialaisWeb.Components.DataTable, only: [sort: 1, search: 1, search_like: 1]

  alias Genialais.Individuals.NameParts

  @type t :: %Individual{}
  
  def list_individuals(params) do
    Individual
    |> select([i, n], [:id, :gender, n: [:givenName, :surname]])
    |> join(:left, [i], assoc(i, :name_parts), as: :name_parts) 
    |> where(^query_given_name(search_like(params)))
    |> or_where(^query_surname(search_like(params)))
    |> or_where(^query_gender(search(params)))
    |> order_by(^filter_order_by(sort(params)))
    |> preload([i, n], name_parts: n)
    |> Repo.all()
  end

  defp query_given_name(query) when not is_nil(query),
    do: dynamic([name_parts: n], like(n.givenName, ^query))
  defp query_given_name(_), do: true

  defp query_surname(query) when not is_nil(query),
    do: dynamic([name_parts: n], like(n.surname, ^query))
  defp query_surname(_), do: true

  defp query_gender(query) when not is_nil(query) do
    existing_genders = Individual
    |> Ecto.Enum.mappings(:gender) 
    |> Keyword.values()
    
    case query in existing_genders do
      true -> [gender: query]
      false -> false 
    end
  end
  defp query_gender(_), do: true

  defp filter_order_by({order, "gender"}),
    do: [{order, dynamic([i], i.gender)}]

  defp filter_order_by({order, "givenName"}),
    do: [{order, dynamic([name_parts: n], n.givenName)}]

  defp filter_order_by({order, "surname"}),
    do: [{order, dynamic([name_parts: n], n.surname)}]

  defp filter_order_by(_),
    do: []
end