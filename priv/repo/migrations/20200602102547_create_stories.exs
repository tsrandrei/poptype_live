defmodule PoptypeLive.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :username, :string
      add :title, :string
      add :body, :string
      add :tags, :string
      add :status, :string

      timestamps()
    end

  end
end
