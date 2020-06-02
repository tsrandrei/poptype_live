defmodule PoptypeLiveWeb.StoryLive.Index do
  use PoptypeLiveWeb, :live_view

  alias PoptypeLive.Stories
  alias PoptypeLive.Stories.Story

  def mount(_params, _session, socket) do
    # if connected?(socket), do: Process.send_after(self(), :drafts)

    {:ok, assign(socket, stories: [], 
          drafts_count: length(list_drafted_stories), 
          posted_count: length(list_posted_stories),
          archived_count: length(list_archived_stories))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Story")
    |> assign(:story, Stories.get_story!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Story")
    |> assign(:story, %Story{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Stories")
    |> assign(:story, nil)
  end

  defp apply_action(socket, :drafts, _params) do
    socket
    |> assign(page_title: "Drafts Stories", 
              stories: list_drafted_stories, 
              drafts_count: length(list_drafted_stories),
              posted_count: length(list_posted_stories),
              archived_count: length(list_archived_stories))
  end

  defp apply_action(socket, :archived, _params) do
    socket
    |> assign(:page_title, "Archived Stories")
    |> assign(:stories, list_archived_stories)
  end

  defp apply_action(socket, :posted, _params) do
    socket
    |> assign(:page_title, "Posted Stories")
    |> assign(:stories, list_posted_stories)
  end

  # defp apply_action(socket, :posted, _params) do
  #   socket
  #   |> assign(:page_title, "Posted Stories")
  #   |> assign(:story, nil)
  # end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    story = Stories.get_story!(id)
    {:ok, _} = Stories.delete_story(story)

    {:noreply, assign(socket, :stories, list_stories())}
  end

  # @impl true
  # def handle_event("drafts", _params ,socket) do
  #   {:noreply, assign(socket, :stories, list_drafted_stories)}
  # end

  # @impl true
  # def handle_event("posted", _params ,socket) do
  #   {:noreply, assign(socket, :stories, list_posted_stories)}
  # end

  # @impl true
  # def handle_event("archived", _params ,socket) do
  #   {:noreply, assign(socket, :stories, list_archived_stories)}
  # end

  defp list_stories do
    Stories.list_stories()
  end

  defp list_drafted_stories do
    Stories.list_stories_with(%{status: "draft"})
  end

  defp list_posted_stories do
    Stories.list_stories_with(%{status: "posted"})
  end

  defp list_archived_stories do
    Stories.list_stories_with(%{status: "archived"})
  end
end
