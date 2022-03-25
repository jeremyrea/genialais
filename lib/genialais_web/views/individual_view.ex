defmodule GenialaisWeb.IndividualView do
  use GenialaisWeb, :view

  def page_title(:new, _assigns), do: gettext("New individual")
  def page_title(_, _), do: gettext("Individuals")
end
