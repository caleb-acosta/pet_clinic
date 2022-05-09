defmodule PetClinic.Repo.Migrations.CreatePetsTypesTable do
  use Ecto.Migration
  alias PetClinic.Repo

  def change do
    # Seleccionamos los nombres de pets
    query_pets = "select id, type from pets;"
    pets = Ecto.Adapters.SQL.query!(Repo, query_pets, []).rows
    # Seleccionamos los nombres de types
    query_types = "select distinct type from pets;"
    types = Ecto.Adapters.SQL.query!(Repo, query_types, []).rows |> List.flatten()

    create table("pet_types") do
      add :name, :string
      timestamps()
    end

    flush()

    Enum.each(types, fn type ->
      query_insert_types = "
        INSERT INTO pet_types 
        (name,inserted_at, updated_at) 
        VALUES($1::varchar, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);"
      Ecto.Adapters.SQL.query!(Repo, query_insert_types, [type])
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()

    Enum.each(pets, fn pet ->
      query_pet_type_id = "
        SELECT id FROM pet_types 
        WHERE name = $1::varchar ;"

      pet_type_id =
        Ecto.Adapters.SQL.query!(Repo, query_pet_type_id, [Enum.at(pet, 1)]).rows
        |> List.flatten()
        |> List.first()

      query_update = "UPDATE pets SET type_id = $1 where id = $2;"
      Ecto.Adapters.SQL.query!(Repo, query_update, [pet_type_id, Enum.at(pet, 0)])
    end)
  end
end
