defmodule PetClinic.Repo.Migrations.RealtePetsToOwner do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :owner_id, references("owners")
    end
  end
end
