defmodule PoptypeLive.InsightsTest do
  use PoptypeLive.DataCase

  alias PoptypeLive.Insights

  describe "insights" do
    alias PoptypeLive.Insights.Insight

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def insight_fixture(attrs \\ %{}) do
      {:ok, insight} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Insights.create_insight()

      insight
    end

    test "list_insights/0 returns all insights" do
      insight = insight_fixture()
      assert Insights.list_insights() == [insight]
    end

    test "get_insight!/1 returns the insight with given id" do
      insight = insight_fixture()
      assert Insights.get_insight!(insight.id) == insight
    end

    test "create_insight/1 with valid data creates a insight" do
      assert {:ok, %Insight{} = insight} = Insights.create_insight(@valid_attrs)
    end

    test "create_insight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Insights.create_insight(@invalid_attrs)
    end

    test "update_insight/2 with valid data updates the insight" do
      insight = insight_fixture()
      assert {:ok, %Insight{} = insight} = Insights.update_insight(insight, @update_attrs)
    end

    test "update_insight/2 with invalid data returns error changeset" do
      insight = insight_fixture()
      assert {:error, %Ecto.Changeset{}} = Insights.update_insight(insight, @invalid_attrs)
      assert insight == Insights.get_insight!(insight.id)
    end

    test "delete_insight/1 deletes the insight" do
      insight = insight_fixture()
      assert {:ok, %Insight{}} = Insights.delete_insight(insight)
      assert_raise Ecto.NoResultsError, fn -> Insights.get_insight!(insight.id) end
    end

    test "change_insight/1 returns a insight changeset" do
      insight = insight_fixture()
      assert %Ecto.Changeset{} = Insights.change_insight(insight)
    end
  end
end
