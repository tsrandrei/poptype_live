defmodule PoptypeLiveWeb.InsightLive.Index do
  use PoptypeLiveWeb, :live_view

  alias PoptypeLive.Insights
  alias PoptypeLive.Insights.Insight
  alias PoptypeLive.Subscribers
  alias PoptypeLive.Subscribers.Subscriber

  @impl true
  def mount(_params, _session, socket) do
    total_subscribers = length(Subscribers.list_subscribers())
    last_subscribers = Subscribers.subscribers_in_last_7_days()
    {:ok, assign(socket, insights: list_insights(), 
                         total_subscribers: total_subscribers,
                         total_subscribers_in_7_days: last_subscribers)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Insight")
    |> assign(:insight, Insights.get_insight!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Insight")
    |> assign(:insight, %Insight{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Insights")
    |> assign(:insight, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    insight = Insights.get_insight!(id)
    {:ok, _} = Insights.delete_insight(insight)

    {:noreply, assign(socket, :insights, list_insights())}
  end

  defp list_insights do
    Insights.list_insights()
  end
  
  defp list_insights do
    
  end
end
