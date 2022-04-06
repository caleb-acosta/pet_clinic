defmodule PetClinic.PetClinicPetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicPets` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: "some sex",
        type: "some type"
      })
      |> PetClinic.PetClinicPets.create_pet()

    pet
  end
end
