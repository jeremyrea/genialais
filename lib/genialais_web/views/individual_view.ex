defmodule GenialaisWeb.IndividualView do
  use GenialaisWeb, :view

  def page_title(:new, _assigns), do: gettext("New individual")
  def page_title(_, _), do: gettext("Individuals")

  def gender_choices do
    [
      "#{gettext("Male")}": :male, 
      "#{gettext("Female")}": :female,
      "#{gettext("Unknown")}": :unknown
    ]
  end

  # Returns fontawesome icon name 
  def gender_icon(gender) do
    case gender do
      :male -> "mars"
      :female -> "venus"
      _ -> "genderless"
    end
  end

  def list_columns do
    [
      givenName: gettext("Given name"),
      surname: gettext("Surname"),
      gender: gettext("Gender")
    ]
  end
end
