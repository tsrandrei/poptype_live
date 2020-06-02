defmodule PoptypeLive.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :body, :string
    field :tags, :string
    field :title, :string
    field :username, :string
    field :status, :string, default: "draft"

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:username, :title, :body, :tags, :status])
    |> validate_required([:username, :title, :body, :tags])
  end
end
