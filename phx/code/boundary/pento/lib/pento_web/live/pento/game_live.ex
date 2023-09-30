#---
# Excerpted from "Programming Phoenix LiveView",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/liveview for more book information.
#---

defmodule PentoWeb.Pento.GameLive do
  use PentoWeb, :live_view

  alias PentoWeb.Pento.Board

  def mount(%{"puzzle" => puzzle}, _session, socket) do
    {:ok, assign(socket, puzzle: puzzle)}
  end

  def render(assigns) do
    ~H"""
    <section class="container">
      <h1>Welcome to Pento!</h1>
      <.live_component module={Board} puzzle={ @puzzle } id="game" />
    </section>
    """
  end
end
