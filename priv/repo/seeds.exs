# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Genialais.Repo.insert!(%Genialais.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

email = Application.fetch_env!(:genialais, :adminEmail)
password_hash = Pow.Ecto.Schema.Password.pbkdf2_hash(
    Application.fetch_env!(:genialais, :adminPassword))

Genialais.Repo.insert!(%Genialais.Users.User{
    email: email, 
    password_hash: password_hash, 
    role: "admin"
})