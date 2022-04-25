defmodule PetClinic.Repo.Migrations.RelatePetsToHealthExpert do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :preferred_expert_id, references("health_experts")
    end
  end
end
