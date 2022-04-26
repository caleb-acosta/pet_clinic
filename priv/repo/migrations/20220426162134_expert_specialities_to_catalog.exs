defmodule PetClinic.Repo.Migrations.ExpertSpecialitiesToCatalog do
  use Ecto.Migration
  alias PetClinic.Repo
  alias PetClinic.PetClinicPets.PetType
  
  def change do

    query_experts = "select id, specialities from health_experts;"
    health_experts = Ecto.Adapters.SQL.query!(Repo, query_experts, []).rows

    create table("expert_specialities") do
      add :health_expert_id, references("health_experts")
      add :pet_type_id, references("pet_types")
    end
    
    flush()

    alter table("health_experts") do
      remove :specialities
    end

    Enum.each(health_experts, fn health_expert -> 
      specialities = Enum.at(health_expert, 1) |> String.downcase |> String.split(~r{,\s+})
      Enum.each(specialities, fn speciality -> 
        speciality = Repo.get_by(PetType, name: speciality)
        
        if  speciality != nil do
            insert_speciality = "
              insert into expert_specialities (health_expert_id, pet_type_id)
              values ($1, $2);"
            Ecto.Adapters.SQL.query!(Repo, insert_speciality, 
            [
              Enum.at(health_expert, 0),
              speciality.id  
            ])
        end
      end)
    end)

  end
end
