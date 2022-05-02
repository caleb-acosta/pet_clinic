defmodule PetClinicWeb.PetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicPets
  alias PetClinic.PetClinicPets.Pet
  alias PetClinic.PetClinicPets.PetType

  def index(conn, _params) do
    pets = PetClinicPets.list_pets()
    render(conn, "index.html", pets: pets)
  end

  def new(conn, _params) do
    changeset = PetClinicPets.change_pet(%Pet{})
    pet_types = PetClinicPets.list_pet_types()
    render(conn, "new.html", changeset: changeset, pet_types: pet_types)
  end

  def create(conn, %{"pet" => pet_params}) do
    case PetClinicPets.create_pet(pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet created successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = PetClinicPets.get_pet!(id) 
    render(conn, "show.html", pet: pet)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetClinicPets.get_pet!(id)
    pet_types = PetClinicPets.list_pet_types()
    changeset = PetClinicPets.change_pet(pet)
    render(conn, "edit.html", pet: pet, changeset: changeset, pet_types: pet_types)
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = PetClinicPets.get_pet!(id)

    case PetClinicPets.update_pet(pet, pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet updated successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet: pet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = PetClinicPets.get_pet!(id)
    {:ok, _pet} = PetClinicPets.delete_pet(pet)

    conn
    |> put_flash(:info, "Pet deleted successfully.")
    |> redirect(to: Routes.pet_path(conn, :index))
  end
  def index_by_type(conn, %{"type" => type}) do
    pets = PetClinicPets.list_pets_by_type(type)      
    render(conn, "index_by_type.html", pets: pets, type: type)
  end
end
