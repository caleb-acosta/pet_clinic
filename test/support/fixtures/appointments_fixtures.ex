defmodule PetClinic.AppointmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        date_time: ~N[2022-04-26 16:03:00]
      })
      |> PetClinic.Appointments.create_appointment()

    appointment
  end
end
