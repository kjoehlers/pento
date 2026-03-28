defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Guess the number", number: Enum.random(1..10))}
  end

  def render(assigns) do
    ~H"""
    <div>
      Score: {@score}
      <br /> Message: {@message}
      <br /> Number: {@number}
    </div>
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <h1 class="mb-4 text-4xl font-extrabold text-red-500">Your score: {@score}</h1>
      <h2>
        {@message}
      </h2>
      <br />
      <h2>
        <%= for n <- 1..10 do %>
          <.link
            class="btn btn-secondary"
            phx-click="guess"
            phx-value-number={n}
          >
            {n}
          </.link>
        <% end %>
      </h2>
    </main>
    """
  end

  def handle_event("guess", %{"number" => number}, socket) do
    if String.to_integer(number) == socket.assigns.number do
      {:noreply,
       assign(socket,
         score: socket.assigns.score + 1,
         message: "You guessed the number! You win!",
         number: Enum.random(1..10)
       )}
    else
      {:noreply,
       assign(socket, score: socket.assigns.score - 1, message: "Wrong number - Try again!")}
    end
  end
end
