defmodule GenialaisWeb.Components.DataTable do
  use GenialaisWeb, :component

  def table(assigns) do
    ~H"""
    <table>
      <thead>
        <tr>
          <th>
            <%= table_link("Name", @params, "name_parts.givenName") %>
          </th>
          <th>
            <%= table_link("Gender", @params, "gender") %>
          </th>
        </tr>
      </thead>
      <tbody>
        <%= for individual <- @data do %>
        <tr>
          <td>
              <%= individual.givenName %>
          </td>
          <td>
              <%= individual.gender %>
          </td>
        </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  defp table_link(label, params, field) do
      params = params
      |> Plug.Conn.Query.encode() 
      |> URI.decode_query()

      direction = params["sort_direction"]

      opts =
          if params["sort_field"] == to_string(field) do
          [
              sort_field: field,
              sort_direction: reverse(direction)
          ]
          else
          [
              sort_field: field,
              sort_direction: "asc"
          ]
          end

      
      link(label, to: "?" <> querystring(params, opts))
  end

  defp querystring(params, opts \\ %{}) do
      opts = %{
      "page" => opts[:page], # For the pagination
      "sort_field" => opts[:sort_field] || params["sort_field"] || nil,
      "sort_direction" => opts[:sort_direction] || params["sort_direction"] || nil
      }

      params
      |> Map.merge(opts)
      |> Enum.filter(fn {_, v} -> v != nil end)
      |> Enum.into(%{})
      |> URI.encode_query()
  end

  defp reverse("desc"), do: "asc"
  defp reverse(_), do: "desc"

  # Exportable helper functions for entity service queries
  def sort(%{"sort_field" => field, "sort_direction" => direction}) when direction in ~w(asc desc) do
    {String.to_atom(direction), field}
  end

  def sort(_other) do
      {:asc, :id}
  end
end