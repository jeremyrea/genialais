defmodule Genialais.Repo do
  use Ecto.Repo,
    otp_app: :genialais,
    adapter: Ecto.Adapters.SQLite3
end
