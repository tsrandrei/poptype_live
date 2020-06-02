defmodule PoptypeLiveWeb.InsightLiveTest do
  use PoptypeLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PoptypeLive.Insights

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:insight) do
    {:ok, insight} = Insights.create_insight(@create_attrs)
    insight
  end

  defp create_insight(_) do
    insight = fixture(:insight)
    %{insight: insight}
  end

  describe "Index" do
    setup [:create_insight]

    test "lists all insights", %{conn: conn, insight: insight} do
      {:ok, _index_live, html} = live(conn, Routes.insight_index_path(conn, :index))

      assert html =~ "Listing Insights"
    end

    test "saves new insight", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.insight_index_path(conn, :index))

      assert index_live |> element("a", "New Insight") |> render_click() =~
               "New Insight"

      assert_patch(index_live, Routes.insight_index_path(conn, :new))

      assert index_live
             |> form("#insight-form", insight: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#insight-form", insight: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.insight_index_path(conn, :index))

      assert html =~ "Insight created successfully"
    end

    test "updates insight in listing", %{conn: conn, insight: insight} do
      {:ok, index_live, _html} = live(conn, Routes.insight_index_path(conn, :index))

      assert index_live |> element("#insight-#{insight.id} a", "Edit") |> render_click() =~
               "Edit Insight"

      assert_patch(index_live, Routes.insight_index_path(conn, :edit, insight))

      assert index_live
             |> form("#insight-form", insight: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#insight-form", insight: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.insight_index_path(conn, :index))

      assert html =~ "Insight updated successfully"
    end

    test "deletes insight in listing", %{conn: conn, insight: insight} do
      {:ok, index_live, _html} = live(conn, Routes.insight_index_path(conn, :index))

      assert index_live |> element("#insight-#{insight.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#insight-#{insight.id}")
    end
  end

  describe "Show" do
    setup [:create_insight]

    test "displays insight", %{conn: conn, insight: insight} do
      {:ok, _show_live, html} = live(conn, Routes.insight_show_path(conn, :show, insight))

      assert html =~ "Show Insight"
    end

    test "updates insight within modal", %{conn: conn, insight: insight} do
      {:ok, show_live, _html} = live(conn, Routes.insight_show_path(conn, :show, insight))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Insight"

      assert_patch(show_live, Routes.insight_show_path(conn, :edit, insight))

      assert show_live
             |> form("#insight-form", insight: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#insight-form", insight: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.insight_show_path(conn, :show, insight))

      assert html =~ "Insight updated successfully"
    end
  end
end
