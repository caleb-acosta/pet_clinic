defmodule PetClinic.Repo.Migrations.RealtePetsToHealthExpert do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :health_expert_id, references("health_experts")
    end
  end
end
