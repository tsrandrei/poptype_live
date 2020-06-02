defmodule PoptypeLive.Insights.Insight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "insights" do

    timestamps()
  end

  @doc false
  def changeset(insight, attrs) do
    insight
    |> cast(attrs, [])
    |> validate_required([])
  end
end
