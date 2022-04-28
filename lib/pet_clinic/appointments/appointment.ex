defmodule PetClinic.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apointments" do
    field :date_time, :naive_datetime
    belongs_to :pet, PetClinic.PetClinicPets.Pet
    belongs_to :health_expert, PetClinic.PetHealthExpert.HealthExpert
    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date_time])
    |> validate_required([:date_time])
  end
end
