defmodule PetClinic.PetHealthExpertFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetHealthExpert` context.
  """

  @doc """
  Generate a health_expert.
  """
  def health_expert_fixture(attrs \\ %{}) do
    {:ok, health_expert} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      })
      |> PetClinic.PetHealthExpert.create_health_expert()

    health_expert
  end
end
