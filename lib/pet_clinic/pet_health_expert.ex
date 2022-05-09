defmodule PetClinic.PetHealthExpert do
  @moduledoc """
  The PetHealthExpert context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetHealthExpert.HealthExpert

  @doc """
  Returns the list of health_experts.

  ## Examples

      iex> list_health_experts()
      [%HealthExpert{}, ...]

  """
  def list_health_experts do
    Repo.all(HealthExpert) |> Repo.preload(:specialities)
  end

  @doc """
  Gets a single health_expert.

  Raises `Ecto.NoResultsError` if the Health expert does not exist.

  ## Examples

      iex> get_health_expert!(123)
      %HealthExpert{}

      iex> get_health_expert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_health_expert!(id), do: Repo.get!(HealthExpert, id) |> Repo.preload(:specialities)

  @doc """
  Creates a health_expert.

  ## Examples

      iex> create_health_expert(%{field: value})
      {:ok, %HealthExpert{}}

      iex> create_health_expert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_health_expert(attrs \\ %{}) do
    %HealthExpert{}
    |> HealthExpert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a health_expert.

  ## Examples

      iex> update_health_expert(health_expert, %{field: new_value})
      {:ok, %HealthExpert{}}

      iex> update_health_expert(health_expert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_health_expert(%HealthExpert{} = health_expert, attrs) do
    health_expert
    |> HealthExpert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a health_expert.

  ## Examples

      iex> delete_health_expert(health_expert)
      {:ok, %HealthExpert{}}

      iex> delete_health_expert(health_expert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_health_expert(%HealthExpert{} = health_expert) do
    Repo.delete(health_expert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking health_expert changes.

  ## Examples

      iex> change_health_expert(health_expert)
      %Ecto.Changeset{data: %HealthExpert{}}

  """
  def change_health_expert(%HealthExpert{} = health_expert, attrs \\ %{}) do
    HealthExpert.changeset(health_expert, attrs)
  end

  def get_health_expert_specialities(id) do
    he = Repo.get!(HealthExpert, id) |> Repo.preload(:specialities)
    he.specialities
  end
end
