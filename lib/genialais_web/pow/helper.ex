defmodule GenialaisWeb.Pow.Helper do
  @spec sync_user(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def sync_user(conn, user), do: Pow.Plug.create(conn, user)
end