defmodule PoptypeLiveWeb.InsightLive.FormComponent do
  use PoptypeLiveWeb, :live_component

  alias PoptypeLive.Insights

  @impl true
  def update(%{insight: insight} = assigns, socket) do
    changeset = Insights.change_insight(insight)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"insight" => insight_params}, socket) do
    changeset =
      socket.assigns.insight
      |> Insights.change_insight(insight_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"insight" => insight_params}, socket) do
    save_insight(socket, socket.assigns.action, insight_params)
  end

  defp save_insight(socket, :edit, insight_params) do
    case Insights.update_insight(socket.assigns.insight, insight_params) do
      {:ok, _insight} ->
        {:noreply,
         socket
         |> put_flash(:info, "Insight updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_insight(socket, :new, insight_params) do
    case Insights.create_insight(insight_params) do
      {:ok, _insight} ->
        {:noreply,
         socket
         |> put_flash(:info, "Insight created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
