defmodule PoptypeLiveWeb.StoryLive.FormComponent do
  use PoptypeLiveWeb, :live_component

  alias PoptypeLive.Stories

  @impl true
  def update(%{story: story} = assigns, socket) do
    changeset = Stories.change_story(story)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"story" => story_params}, socket) do
    changeset =
      socket.assigns.story
      |> Stories.change_story(story_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"story" => story_params}, socket) do
    save_story(socket, socket.assigns.action, story_params)
  end

  defp save_story(socket, :edit, story_params) do
    case Stories.update_story(socket.assigns.story, story_params) do
      {:ok, _story} ->
        {:noreply,
         socket
         |> put_flash(:info, "Story updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_story(socket, :new, story_params) do
    case Stories.create_story(story_params) do
      {:ok, _story} ->
        {:noreply,
         socket
         |> put_flash(:info, "Story created successfully")
         |> push_redirect(to: socket.assigns.return_to)}
         
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
