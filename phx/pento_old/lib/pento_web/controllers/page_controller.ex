defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    if Map.has_key?(conn.assigns, :current_user) do
      redirect(conn, to: "/guess")
    else
      render(conn, "index.html")
    end
  end
end
