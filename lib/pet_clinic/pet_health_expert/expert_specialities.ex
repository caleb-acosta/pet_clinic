defmodule PetClinic.PetHealthExpert.ExpertSpecialities do
  use Ecto.Schema

  schema "expert_specialities" do
    field :health_expert_id, :integer
    field :pet_type_id, :integer
  end

end
