defmodule PetClinic.ExpertSchedules do
  @moduledoc """
  The ExpertSchedules context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.ExpertSchedules.ExpertSchedule

  @doc """
  Returns the list of expert_schedules.

  ## Examples

      iex> list_expert_schedules()
      [%ExpertSchedule{}, ...]

  """
  def list_expert_schedules do
    Repo.all(ExpertSchedule)
  end

  @doc """
  Gets a single expert_schedule.

  Raises `Ecto.NoResultsError` if the Expert schedule does not exist.

  ## Examples

      iex> get_expert_schedule!(123)
      %ExpertSchedule{}

      iex> get_expert_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_schedule!(id), do: Repo.get!(ExpertSchedule, id)

  @doc """
  Creates a expert_schedule.

  ## Examples

      iex> create_expert_schedule(%{field: value})
      {:ok, %ExpertSchedule{}}

      iex> create_expert_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_schedule(attrs \\ %{}) do
    %ExpertSchedule{}
    |> ExpertSchedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_schedule.

  ## Examples

      iex> update_expert_schedule(expert_schedule, %{field: new_value})
      {:ok, %ExpertSchedule{}}

      iex> update_expert_schedule(expert_schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs) do
    expert_schedule
    |> ExpertSchedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_schedule.

  ## Examples

      iex> delete_expert_schedule(expert_schedule)
      {:ok, %ExpertSchedule{}}

      iex> delete_expert_schedule(expert_schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_schedule(%ExpertSchedule{} = expert_schedule) do
    Repo.delete(expert_schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_schedule changes.

  ## Examples

      iex> change_expert_schedule(expert_schedule)
      %Ecto.Changeset{data: %ExpertSchedule{}}

  """
  def change_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs \\ %{}) do
    ExpertSchedule.changeset(expert_schedule, attrs)
  end
end
