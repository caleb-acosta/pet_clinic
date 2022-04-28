defmodule PetClinic.ExpertSchedules.ExpertSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_schedules" do
    field :day, :integer
    field :from_hour, :time
    field :health_expert_id, :integer
    field :to_hour, :time

    timestamps()
  end

  @doc false
  def changeset(expert_schedule, attrs) do
    expert_schedule
    |> cast(attrs, [:day, :health_expert_id, :from_hour, :to_hour])
    |> validate_required([:day, :health_expert_id, :from_hour, :to_hour])
  end
end
