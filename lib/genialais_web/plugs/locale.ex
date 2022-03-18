defmodule GenialaisWeb.Plugs.Locale do
  import Plug.Conn
  use GenialaisWeb.CurrentUser

  alias GenialaisWeb.Router.Helpers, as: Routes
  alias Plug.Conn
  alias Pow.Plug

  def action_name(_conn) do
    :locale
  end

  def init(default_locale), do: default_locale
  
  def call(conn, current_user) do
    conn
    |> Plug.current_user()
    |> set_locale()
    conn
  end

  def set_locale(nil), do: nil
  def set_locale(current_user) do
    Gettext.put_locale(GenialaisWeb.Gettext, current_user.locale)
  end
end