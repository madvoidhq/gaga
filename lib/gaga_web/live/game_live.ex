defmodule GagaWeb.GameLive do
  use GagaWeb, :live_view

  @clean_player_state [
    cards_flipped?: false,
    current_vote: nil
  ]

  @impl Phoenix.LiveView
  def render(assigns) do
    GagaWeb.GameView.render("show.html", assigns)
  end

  @impl Phoenix.LiveView
  def mount(_params, %{"current_user" => current_user, "game_name" => game_name}, socket) do
    # Register this live view's process as a presence for the current_user on
    # the game topic. Set user name and current vote as presence metadata
    GagaWeb.Presence.track(self(), topic(game_name), current_user.id, %{
      name: current_user.name,
      vote: nil
    })

    # Subscribe to notifications for the game topic
    if connected?(socket), do: Phoenix.PubSub.subscribe(Gaga.PubSub, topic(game_name))

    socket =
      socket
      |> assign(current_user: current_user, game_name: game_name)
      |> assign(@clean_player_state)
      |> refresh_game_state

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("flip_cards", _, socket) do
    Phoenix.PubSub.broadcast(Gaga.PubSub, topic(socket.assigns.game_name), "flip_cards")
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("new_round", _, socket) do
    Phoenix.PubSub.broadcast(Gaga.PubSub, topic(socket.assigns.game_name), "new_round")
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("vote", %{"vote" => vote}, socket) do
    update_presence(socket, &Map.put(&1, :vote, vote))

    {:noreply, assign(socket, current_vote: vote)}
  end

  @impl Phoenix.LiveView
  def handle_info("flip_cards", socket) do
    {:noreply, assign(socket, cards_flipped?: true)}
  end

  @impl Phoenix.LiveView
  def handle_info("new_round", socket) do
    update_presence(socket, &Map.put(&1, :vote, nil))

    {:noreply, assign(socket, @clean_player_state)}
  end

  @impl Phoenix.LiveView
  def handle_info(%{event: "presence_diff"}, socket) do
    {:noreply, refresh_game_state(socket)}
  end

  defp update_presence(socket, fun) do
    GagaWeb.Presence.update(
      self(),
      topic(socket.assigns.game_name),
      socket.assigns.current_user.id,
      fun
    )
  end

  defp refresh_game_state(socket) do
    players = list_players(socket)
    votes = Enum.map(players, & &1.vote)
    # We compute this here as we'll only pass non nil votes to the view
    everyone_voted? = Enum.all?(votes, &(&1 != nil))

    assign(socket, %{
      everyone_voted?: everyone_voted?,
      players: players,
      votes: Enum.reject(votes, &is_nil/1)
    })
  end

  defp topic(game_name) do
    "game:#{game_name}"
  end

  # Presence -> %{id: player.id, name: player.name, vote: player.vote}
  defp list_players(socket) do
    entries = GagaWeb.Presence.list(topic(socket.assigns.game_name))

    for {player_id, %{metas: metas}} <- entries, into: [] do
      Map.merge(List.first(metas), %{id: player_id})
    end
  end
end
