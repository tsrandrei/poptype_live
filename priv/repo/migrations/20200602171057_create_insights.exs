defmodule PoptypeLive.Repo.Migrations.CreateInsights do
  use Ecto.Migration

  def change do
    create table(:insights) do

      timestamps()
    end

  end
end
