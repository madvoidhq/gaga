defmodule GagaWeb.PageController do
  use GagaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
