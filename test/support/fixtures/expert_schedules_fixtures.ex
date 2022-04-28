defmodule PetClinic.ExpertSchedulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.ExpertSchedules` context.
  """

  @doc """
  Generate a expert_schedule.
  """
  def expert_schedule_fixture(attrs \\ %{}) do
    {:ok, expert_schedule} =
      attrs
      |> Enum.into(%{
        day: "some day",
        from_hour: ~T[14:00:00],
        health_expert_id: 42,
        to_hour: ~T[14:00:00]
      })
      |> PetClinic.ExpertSchedules.create_expert_schedule()

    expert_schedule
  end
end
