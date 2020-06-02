defmodule PoptypeLiveWeb.InsightLive.Show do
  use PoptypeLiveWeb, :live_view

  alias PoptypeLive.Insights

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:insight, Insights.get_insight!(id))}
  end

  defp page_title(:show), do: "Show Insight"
  defp page_title(:edit), do: "Edit Insight"
end
