defmodule GagaWeb.SessionController do
  use GagaWeb, :controller

  alias GagaWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => %{"name" => name}}) do
    user = Gaga.Player.new(name)

    UserAuth.login_user(conn, user)
  end

  def create(conn, _params) do
    conn
    |> put_flash(:error, "Invalid data.")
    |> render("new.html")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.logout_user()
  end
end
