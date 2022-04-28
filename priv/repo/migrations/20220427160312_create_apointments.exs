defmodule PetClinic.Repo.Migrations.CreateApointments do
  use Ecto.Migration

  def change do
    create table(:apointments) do
      add :date_time, :naive_datetime
      add :pet_id, :integer
      add :health_expert_id, :integer 
      timestamps()
    end
  end
end
