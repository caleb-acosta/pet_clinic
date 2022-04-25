defmodule PetClinic.PetClinicPets.PetType do
    use Ecto.Schema
    
    schema "pet_types" do
      field :name, :string
      has_many :pets, PetClinic.PetClinicPets.Pet, foreign_key: :type_id
      timestamps()
    end
end
