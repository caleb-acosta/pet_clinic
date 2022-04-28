defmodule PetClinic.Repo.Migrations.CreateExpertSchedules do
  use Ecto.Migration

  def change do
    create table(:expert_schedules) do
      add :day, :integer
      add :health_expert_id, :integer
      add :from_hour, :time
      add :to_hour, :time

      timestamps()
    end
  end
end
