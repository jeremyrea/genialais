defmodule GenialaisWeb.LayoutView do
  use GenialaisWeb, :view

  alias Genialais.Users.User

  def page_title(conn, assigns) do
    try do
      base_name = default_page_title()
      page = apply(view_module(conn), :page_title, [action_name(conn), assigns])
      "#{base_name} - #{page}"
    rescue
      UndefinedFunctionError -> default_page_title(conn, assigns)
    end
  end

  def default_page_title(), do: "Genialais"
  def default_page_title(_conn, _assigns), do: default_page_title

  def languages do
    [
      "🇬🇧": "en", 
      "🇫🇷": "fr"
    ]
  end

  def active_class(conn, path) do
    [_head | [base_path | _tail]] = String.split(path, "/")

    conn.path_info
    |> List.first("")
    |> String.equivalent?(base_path)
    |> case do
      true -> "active"
      false -> nil
    end
  end

  def active_link(conn, text, opts) do
    class = [opts[:class], active_class(conn, opts[:to])]
            |> Enum.filter(& &1) 
            |> Enum.join(" ")
    opts = opts
          |> Keyword.put(:class, class)
    link(text, opts)
  end
end
