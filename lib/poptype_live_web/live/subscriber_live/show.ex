defmodule PoptypeLiveWeb.SubscriberLive.Show do
  use PoptypeLiveWeb, :live_view

  alias PoptypeLive.Subscribers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:subscriber, Subscribers.get_subscriber!(id))}
  end

  defp page_title(:show), do: "Show Subscriber"
  defp page_title(:edit), do: "Edit Subscriber"
end
