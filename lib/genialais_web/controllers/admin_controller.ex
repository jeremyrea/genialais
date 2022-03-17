defmodule GenialaisWeb.AdminController do
  use GenialaisWeb, :controller
  use GenialaisWeb.CurrentUser

  alias Genialais.Users
  alias Genialais.Users.User

  def action(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _opts) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, current_user])
  end

  def index(conn, _params, _current_user) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def create(conn, %{"email" => email}, current_user) do
    {:ok, new_user} = PowInvitation.Ecto.Context.create(current_user, %{email: email}, otp_app: :genialais)
    conn |> redirect(to: "/admin")
  end

  def update(conn, %{"uid" => uid, "role" => role}, _current_user) do
    uid
    |> Users.get_user()
    |> Users.set_role(role)

    conn |> redirect(to: "/admin") 
  end

  def delete(conn, %{"uid" => uid}, _current_user) do
    uid 
    |> String.to_integer
    |> Users.delete_user

    conn |> redirect(to: "/admin") 
  end
end
