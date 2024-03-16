defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {:ok,
      assign(
        socket,
        score: 0,
        message: "Make a guess:",
        answer: :rand.uniform(10),
        won: false,
        session_id: session["live_socket_id"])
    }
  end

  def handle_params(_params, _uri, socket) do
    {:noreply,
      assign(
        socket,
        score: 0,
        message: "Make a guess:",
        answer: :rand.uniform(10),
        won: false
      )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= if !@won do %>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
        <% end %>
      <% end %>
      <%= live_patch to: Routes.live_path(@socket, __MODULE__), replace: true do %>
        <button>Try again!</button>
      <%end%>
      <pre>
        <%= @current_user.email %>
        <%= @current_user.username %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    [message, score, won] =
      if Integer.parse(guess) |> elem(0) == socket.assigns.answer do
        ["Your guess: #{guess}. Correct! " <> (if socket.assigns.score + 5 > 0, do: "You win!", else: "You lose :("), socket.assigns.score + 5, true]
      else
        ["Your guess: #{guess}. Wrong. Guess again. ", socket.assigns.score - 1, false]
      end
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        won: won)
    }
  end
end
