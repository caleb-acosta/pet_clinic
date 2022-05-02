defmodule PetClinicWeb.HealthExpertController do
  use PetClinicWeb, :controller

  alias PetClinic.PetHealthExpert
  alias PetClinic.PetHealthExpert.HealthExpert
  alias PetClinic.PetClinicPets
  alias PetClinic.PetClinicPetOwner

  def index(conn, _params) do
    health_experts = PetHealthExpert.list_health_experts()
    render(conn, "index.html", health_experts: health_experts)
  end

  def new(conn, _params) do
    changeset = PetHealthExpert.change_health_expert(%HealthExpert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"health_expert" => health_expert_params}) do
    case PetHealthExpert.create_health_expert(health_expert_params) do
      {:ok, health_expert} ->
        conn
        |> put_flash(:info, "Health expert created successfully.")
        |> redirect(to: Routes.health_expert_path(conn, :show, health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    health_expert = PetHealthExpert.get_health_expert!(id)
    render(conn, "show.html", health_expert: health_expert)
  end

  def edit(conn, %{"id" => id}) do
    health_expert = PetHealthExpert.get_health_expert!(id)
    changeset = PetHealthExpert.change_health_expert(health_expert)
    render(conn, "edit.html", health_expert: health_expert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "health_expert" => health_expert_params}) do
    health_expert = PetHealthExpert.get_health_expert!(id)

    case PetHealthExpert.update_health_expert(health_expert, health_expert_params) do
      {:ok, health_expert} ->
        conn
        |> put_flash(:info, "Health expert updated successfully.")
        |> redirect(to: Routes.health_expert_path(conn, :show, health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", health_expert: health_expert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    health_expert = PetHealthExpert.get_health_expert!(id)
    {:ok, _health_expert} = PetHealthExpert.delete_health_expert(health_expert)

    conn
    |> put_flash(:info, "Health expert deleted successfully.")
    |> redirect(to: Routes.health_expert_path(conn, :index))
  end

  def show_expert_appointments(conn, %{"id"=> id, "date" => date}) do
    appointments = PetClinic.Appointments.get_expert_appointments(id, date)
    expert = PetHealthExpert.get_health_expert!(id)
    pets = Enum.map(appointments, &(PetClinicPets.get_pet!(&1.pet_id)))
    owners = Enum.map(pets, &PetClinicPetOwner.get_owner!(&1.owner_id))
    render(conn, "show_expert_appointments.html", owners: owners, pets: pets, appointments: appointments, date: date, expert: expert)
  end
end
