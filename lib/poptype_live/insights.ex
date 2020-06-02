defmodule PoptypeLive.Insights do
  @moduledoc """
  The Insights context.
  """

  import Ecto.Query, warn: false
  alias PoptypeLive.Repo

  alias PoptypeLive.Insights.Insight

  @doc """
  Returns the list of insights.

  ## Examples

      iex> list_insights()
      [%Insight{}, ...]

  """
  def list_insights do
    Repo.all(Insight)
  end

  @doc """
  Gets a single insight.

  Raises `Ecto.NoResultsError` if the Insight does not exist.

  ## Examples

      iex> get_insight!(123)
      %Insight{}

      iex> get_insight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_insight!(id), do: Repo.get!(Insight, id)

  @doc """
  Creates a insight.

  ## Examples

      iex> create_insight(%{field: value})
      {:ok, %Insight{}}

      iex> create_insight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_insight(attrs \\ %{}) do
    %Insight{}
    |> Insight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a insight.

  ## Examples

      iex> update_insight(insight, %{field: new_value})
      {:ok, %Insight{}}

      iex> update_insight(insight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_insight(%Insight{} = insight, attrs) do
    insight
    |> Insight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a insight.

  ## Examples

      iex> delete_insight(insight)
      {:ok, %Insight{}}

      iex> delete_insight(insight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_insight(%Insight{} = insight) do
    Repo.delete(insight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking insight changes.

  ## Examples

      iex> change_insight(insight)
      %Ecto.Changeset{data: %Insight{}}

  """
  def change_insight(%Insight{} = insight, attrs \\ %{}) do
    Insight.changeset(insight, attrs)
  end
end
