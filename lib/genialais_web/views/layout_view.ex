defmodule GenialaisWeb.LayoutView do
  use GenialaisWeb, :view

  alias Genialais.Users.User

  def languages do
    [
      "🇬🇧": "en", 
      "🇫🇷": "fr"
    ]
  end
end
