defmodule GenialaisWeb.PageController do
  use GenialaisWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
