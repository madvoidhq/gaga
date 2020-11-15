defmodule GagaWeb.GameController do
  use GagaWeb, :controller

  import Phoenix.LiveView.Controller

  def create(conn, _params) do
    game_name = Gaga.SimpleId.new()
    redirect(conn, to: Routes.game_path(conn, :show, game_name))
  end

  def show(conn, %{"id" => game_name}) do
    live_render(conn, GagaWeb.GameLive,
      session: %{
        "game_name" => game_name,
        "current_user" => get_session(conn, :current_user)
      }
    )
  end
end
