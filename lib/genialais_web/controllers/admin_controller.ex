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
    |> case do
      {:ok, user} ->
        conn
        |> sync_user(user)
        |> redirect(to: "/admin") 
    end
  end

  def delete(conn, %{"uid" => uid}) do
    uid 
    |> String.to_integer
    |> Users.delete_user

    conn |> redirect(to: "/admin") 
  end
end
