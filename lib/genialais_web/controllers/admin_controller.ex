defmodule GenialaisWeb.AdminController do
  use GenialaisWeb, :controller

  alias Genialais.Users
  alias Genialais.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def update(conn, %{"uid" => uid, "role" => role}) do
    uid
    |> Users.get_user()
    |> Users.set_role(role)

    conn |> redirect(to: "/admin") 
  end
end
