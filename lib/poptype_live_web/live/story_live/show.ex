defmodule PoptypeLiveWeb.StoryLive.Show do
  use PoptypeLiveWeb, :live_view

  alias PoptypeLive.Stories

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:story, Stories.get_story!(id))}
  end

  defp page_title(:show), do: "Show Story"
  defp page_title(:edit), do: "Edit Story"
end