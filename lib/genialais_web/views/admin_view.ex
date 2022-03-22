defmodule GenialaisWeb.AdminView do
  use GenialaisWeb, :view

  def page_title(_, _), do: gettext("Admin")
end
