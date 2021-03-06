defmodule PetClinic.PetClinicPets.Pet do
  @moduledoc """
    Pet Clinic Pets Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    belongs_to :type, PetClinic.PetClinicPets.PetType
    belongs_to :owner, PetClinic.PetClinicPetOwner.Owner
    belongs_to :preferred_expert, PetClinic.PetHealthExpert.HealthExpert
    timestamps()
  end

  @doc false
  def changeset(pet, attrs \\ %{}) do
    pet
    |> cast(attrs, [:name, :age, :type_id, :sex])
    # |> cast_assoc(type:, with: PetClinic.PetClinicPets.PetType)
    |> validate_required([:name, :age, :type_id, :sex])
    |> validate_number(:age, greater_than_or_equal_to: 0)
  end
end
