defmodule PetClinic.PetHealthExpert.HealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "health_experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, :string
    field :specialities, :string

    timestamps()
  end

  @doc false
  def changeset(health_expert, attrs) do
    health_expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end
