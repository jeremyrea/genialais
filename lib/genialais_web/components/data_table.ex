defmodule GenialaisWeb.Components.DataTable do
  use GenialaisWeb, :component

  @spec table(%{params: map(), data: map(), controller: string}) :: String
  def table(assigns) do
    ~H"""
    <div class="datatable">
      <%= form_for :search, "#{@controller}/search", fn f -> %>
        <%= search_input f, :query, value: @params["query"] %>
        <button type="submit">
           <FontAwesome.LiveView.icon name="magnifying-glass" />
        </button>
      <% end %>
      <table>
        <thead>
          <tr>
            <%= for {key, title} <- @data.columns do %>
              <th>
                <%= table_link(title, @params, key) %>
              </th>
            <% end %>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <%= for row <- @data.rows do %>
          <tr>
            <%= for {key, _} <- @data.columns do %>
              <td>
                <%= row[key] %>
              </td>
            <% end %>
            <td>
              <%= link "Edit", to: "#{@controller}/#{row[:id]}" %>
            </td>
          </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  @spec table_link(String.t, map(), String.t) :: String
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

  @spec querystring(map(), map()) :: String
  defp querystring(params, opts \\ %{}) do
      opts = %{
      "page" => opts[:page], # For the pagination
      "sort_field" => opts[:sort_field] || params["sort_field"] || nil,
      "sort_direction" => opts[:sort_direction] || params["sort_direction"] || nil,
      "query" => opts[:query] || params["query"] || nil
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
  def search(%{"query" => query}) do
    case query do
      "" -> nil
      _ -> "#{query}"
    end
  end

  def search(_) do
    nil
  end

  def search_like(%{"query" => query}) do
    case query do
      "" -> nil
      _ -> "%#{query}%"
    end
  end

  def search_like(_) do
    nil
  end

  def sort(%{"sort_field" => field, "sort_direction" => direction}) when direction in ~w(asc desc) do
    {String.to_atom(direction), field}
  end

  def sort(_other) do
      {:asc, :id}
  end
end