defmodule PetClinicWeb.OwnerController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicPetOwner
  alias PetClinic.PetClinicPetOwner.Owner

  def index(conn, _params) do
    owners = PetClinicPetOwner.list_owners()
    render(conn, "index.html", owners: owners)
  end

  def new(conn, _params) do
    changeset = PetClinicPetOwner.change_owner(%Owner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"owner" => owner_params}) do
    case PetClinicPetOwner.create_owner(owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner created successfully.")
        |> redirect(to: Routes.owner_path(conn, :show, owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = PetClinicPetOwner.get_owner!(id)
    render(conn, "show.html", owner: owner)
  end

  def edit(conn, %{"id" => id}) do
    owner = PetClinicPetOwner.get_owner!(id)
    changeset = PetClinicPetOwner.change_owner(owner)
    render(conn, "edit.html", owner: owner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = PetClinicPetOwner.get_owner!(id)

    case PetClinicPetOwner.update_owner(owner, owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner updated successfully.")
        |> redirect(to: Routes.owner_path(conn, :show, owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", owner: owner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = PetClinicPetOwner.get_owner!(id)
    {:ok, _owner} = PetClinicPetOwner.delete_owner(owner)

    conn
    |> put_flash(:info, "Owner deleted successfully.")
    |> redirect(to: Routes.owner_path(conn, :index))
  end
end
