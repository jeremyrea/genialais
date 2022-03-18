defmodule GenialaisWeb.UserController do
  use GenialaisWeb, :controller
  use GenialaisWeb.CurrentUser

  alias Genialais.Users
  alias Genialais.Users.User

  def update(conn, %{"locale" => locale, "redirect_to" => redirect_to}, current_user) do
    current_user.id
    |> Users.get_user()
    |> Users.set_locale(locale)
    |> case do
      {:ok, user} ->
        conn
        |> sync_user(user)
        |> redirect(to: redirect_to) 
    end
  end
end
