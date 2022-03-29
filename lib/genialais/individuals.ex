defmodule Genialais.Individuals do
  alias Genialais.{Repo, Individuals.Individual}
  import Ecto.Query

  @type t :: %Individual{}

  def list_individuals() do
    Individual 
    |> order_by(desc: :id) 
    |> Repo.all
    |> Repo.preload [:name_parts]
  end
end