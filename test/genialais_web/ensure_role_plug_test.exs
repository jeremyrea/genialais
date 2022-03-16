defmodule GenialaisWeb.EnsureRolePlugTest do
  use GenialaisWeb.ConnCase

  alias GenialaisWeb.EnsureRolePlug

  @opts ~w(admin)a
  @visitor %{id: 1, role: "visitor"}
  @admin %{id: 2, role: "admin"}

  setup do
    conn =
      build_conn()
      |> Plug.Conn.put_private(:plug_session, %{})
      |> Plug.Conn.put_private(:plug_session_fetch, :done)
      |> Pow.Plug.put_config(otp_app: :genialais)
      |> fetch_flash()

    {:ok, conn: conn}
  end

  test "call/2 with no user", %{conn: conn} do
    opts = EnsureRolePlug.init(@opts)
    conn = EnsureRolePlug.call(conn, opts)

    assert conn.halted
    assert Phoenix.ConnTest.redirected_to(conn) == Routes.page_path(conn, :index)
  end

  test "call/2 with non-admin user", %{conn: conn} do
    opts = EnsureRolePlug.init(@opts)
    conn =
      conn
      |> Pow.Plug.assign_current_user(@visitor, otp_app: :genialais)
      |> EnsureRolePlug.call(opts)

    assert conn.halted
    assert Phoenix.ConnTest.redirected_to(conn) == Routes.page_path(conn, :index)
  end

  test "call/2 with non-admin user and multiple roles", %{conn: conn} do
    opts = EnsureRolePlug.init(~w(visitor editor admin)a)
    conn =
      conn
      |> Pow.Plug.assign_current_user(@visitor, otp_app: :genialais)
      |> EnsureRolePlug.call(opts)

    refute conn.halted
  end

  test "call/2 with admin user", %{conn: conn} do
    opts = EnsureRolePlug.init(@opts)
    conn =
      conn
      |> Pow.Plug.assign_current_user(@admin, otp_app: :genialais)
      |> EnsureRolePlug.call(opts)

    refute conn.halted
  end
end