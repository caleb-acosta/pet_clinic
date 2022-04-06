defmodule PetClinic.Repo.Migrations.CreateHealthExperts do
  use Ecto.Migration

  def change do
    create table(:health_experts) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :specialities, :string
      add :sex, :string

      timestamps()
    end
  end
end
