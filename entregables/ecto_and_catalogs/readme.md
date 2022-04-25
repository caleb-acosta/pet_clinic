# Evidencia

## Antes:

iex(21)> Repo.get!(Pet, 1)                                  
[debug] QUERY OK source="pets" db=1.5ms idle=999.3ms
SELECT p0."id", p0."age", p0."name", p0."sex", p0."type", p0."owner_id", p0."preferred_expert_id", p0."inserted_at", p0."updated_at" FROM "pets" AS p0 WHERE (p0."id" = $1) [1]
%PetClinic.PetClinicPets.Pet{
  __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
  age: -1,
  id: 1,
  inserted_at: ~N[2022-04-20 15:33:57],
  name: "Rocky",
  owner: #Ecto.Association.NotLoaded<association :owner is not loaded>,
  owner_id: nil,
  preferred_expert: #Ecto.Association.NotLoaded<association :preferred_expert is not loaded>,
  preferred_expert_id: nil,
  sex: :male,
  type: "Cat",
  updated_at: ~N[2022-04-21 16:37:37]
}

## Despues

iex(30)> Repo.get!(Pet, 1) |> Repo.preload(:type)
[debug] QUERY OK source="pets" db=1.2ms idle=1731.0ms
SELECT p0."id", p0."age", p0."name", p0."sex", p0."type_id", p0."owner_id", p0."preferred_expert_id", p0."inserted_at", p0."updated_at" FROM "pets" AS p0 WHERE (p0."id" = $1) [1]
[debug] QUERY OK source="pet_types" db=0.4ms queue=0.4ms idle=1733.7ms
SELECT p0."id", p0."name", p0."inserted_at", p0."updated_at", p0."id" FROM "pet_types" AS p0 WHERE (p0."id" = $1) [2]
%PetClinic.PetClinicPets.Pet{
  __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
  age: -1,
  id: 1,
  inserted_at: ~N[2022-04-20 15:33:57],
  name: "Rocky",
  owner: #Ecto.Association.NotLoaded<association :owner is not loaded>,
  owner_id: nil,
  preferred_expert: #Ecto.Association.NotLoaded<association :preferred_expert is not loaded>,
  preferred_expert_id: nil,
  sex: :male,
  type: %PetClinic.PetClinicPets.PetType{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pet_types">,
    id: 2,
    inserted_at: ~N[2022-04-25 23:47:48],
    name: "cat",
    pets: #Ecto.Association.NotLoaded<association :pets is not loaded>,
    updated_at: ~N[2022-04-25 23:47:48]
  },
  type_id: 2,
  updated_at: ~N[2022-04-21 16:37:37]
}

