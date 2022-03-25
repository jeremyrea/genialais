defmodule GenialaisWeb.IndividualView do
  use GenialaisWeb, :view

  def page_title(_, _), do: gettext("Individuals")
  def page_title(:new, assigns), do: gettext("New individual")
end
