defmodule PetClinic.Repo.Migrations.CorrectFieldSexInPetsAndHealthExperts do
  use Ecto.Migration
  alias PetClinic.Repo
  def change do
    query_pets = "select id, sex from pets"
    pets =  Ecto.Adapters.SQL.query!(Repo, query_pets).rows
    Enum.each(pets, fn p -> 
      cond do
        String.jaro_distance("male", Enum.at(p, 1)) > 0.83 -> 
          update = "update pets set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["male", Enum.at(p, 0)])
        String.jaro_distance("female", Enum.at(p, 1)) > 0.83 -> 
          update = "update pets set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["female", Enum.at(p, 0)])
        true -> 
          update = "update pets set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["male", Enum.at(p, 0)])
      end
    end)

    query_health_experts = "select id, sex from health_experts"
    health_experts = Ecto.Adapters.SQL.query!(Repo, query_health_experts).rows
    Enum.each(health_experts, fn he ->
      cond do
        String.jaro_distance("male", Enum.at(he, 1)) > 0.83 -> 
          update = "update health_experts set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["male", Enum.at(he, 0)])
        String.jaro_distance("female", Enum.at(he, 1)) > 0.83 ->  
          update = "update health_experts set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["female", Enum.at(he, 0)])
        true ->  
          update = "update health_experts set sex = $1 where id = $2"
          Ecto.Adapters.SQL.query!(Repo, update, ["male",  Enum.at(he, 0)])
      end
    end)
  end
end
