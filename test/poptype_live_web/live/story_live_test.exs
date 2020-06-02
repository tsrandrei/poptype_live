defmodule PoptypeLiveWeb.StoryLiveTest do
  use PoptypeLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PoptypeLive.Stories

  @create_attrs %{body: "some body", tags: "some tags", title: "some title", username: "some username"}
  @update_attrs %{body: "some updated body", tags: "some updated tags", title: "some updated title", username: "some updated username"}
  @invalid_attrs %{body: nil, tags: nil, title: nil, username: nil}

  defp fixture(:story) do
    {:ok, story} = Stories.create_story(@create_attrs)
    story
  end

  defp create_story(_) do
    story = fixture(:story)
    %{story: story}
  end

  describe "Index" do
    setup [:create_story]

    test "lists all stories", %{conn: conn, story: story} do
      {:ok, _index_live, html} = live(conn, Routes.story_index_path(conn, :index))

      assert html =~ "Listing Stories"
      assert html =~ story.body
    end

    test "saves new story", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.story_index_path(conn, :index))

      assert index_live |> element("a", "New Story") |> render_click() =~
               "New Story"

      assert_patch(index_live, Routes.story_index_path(conn, :new))

      assert index_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#story-form", story: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.story_index_path(conn, :index))

      assert html =~ "Story created successfully"
      assert html =~ "some body"
    end

    test "updates story in listing", %{conn: conn, story: story} do
      {:ok, index_live, _html} = live(conn, Routes.story_index_path(conn, :index))

      assert index_live |> element("#story-#{story.id} a", "Edit") |> render_click() =~
               "Edit Story"

      assert_patch(index_live, Routes.story_index_path(conn, :edit, story))

      assert index_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#story-form", story: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.story_index_path(conn, :index))

      assert html =~ "Story updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes story in listing", %{conn: conn, story: story} do
      {:ok, index_live, _html} = live(conn, Routes.story_index_path(conn, :index))

      assert index_live |> element("#story-#{story.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#story-#{story.id}")
    end
  end

  describe "Show" do
    setup [:create_story]

    test "displays story", %{conn: conn, story: story} do
      {:ok, _show_live, html} = live(conn, Routes.story_show_path(conn, :show, story))

      assert html =~ "Show Story"
      assert html =~ story.body
    end

    test "updates story within modal", %{conn: conn, story: story} do
      {:ok, show_live, _html} = live(conn, Routes.story_show_path(conn, :show, story))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Story"

      assert_patch(show_live, Routes.story_show_path(conn, :edit, story))

      assert show_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#story-form", story: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.story_show_path(conn, :show, story))

      assert html =~ "Story updated successfully"
      assert html =~ "some updated body"
    end
  end
end
