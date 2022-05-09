defmodule PetClinic.Appointments do
  @moduledoc """
  The Appointments context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo
  alias PetClinic.ExpertSchedules.ExpertSchedule
  alias PetClinic.Appointments.Appointment
  alias PetClinic.PetClinicPets.Pet
  alias PetClinic.PetHealthExpert.HealthExpert

  @doc """
  Returns the list of apointments.

  ## Examples

      iex> list_apointments()
      [%Appointment{}, ...]

  """
  def list_apointments do
    Repo.all(Appointment)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{data: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment, attrs \\ %{}) do
    Appointment.changeset(appointment, attrs)
  end

  #def available_slots(expert_id, from_date, to_date) do
  #  query_schedule = from s in ExperSchedule, where: s.health_expert_id==expert_id
  #  schedule = Repo.all(query_schedule)
  #end

  def get_expert_appointments(expert_id, date) do
    start_of_day = NaiveDateTime.new!(Date.from_iso8601!(date), ~T[00:00:00])
    end_of_day = NaiveDateTime.new!(Date.from_iso8601!(date), ~T[23:59:59])
    Repo.all(from a in Appointment, where: a.date_time < ^end_of_day, where: a.date_time > ^start_of_day, where: a.health_expert_id == ^expert_id)
  end

  #Get list of slots available in a specific date
  def get_slots_day(expert_id, day) do
    working_schedule = Repo.get_by(ExpertSchedule, health_expert_id: expert_id, day: Timex.weekday(day))
    if working_schedule != nil do
      calculate_slots_day(expert_id, day, working_schedule.from_hour, working_schedule.to_hour, [] )
    else
      []
    end
  end

  def calculate_slots_day(expert_id, day, start_time, end_time, acc) when start_time <= end_time do
    acc = 
      if (Repo.get_by(Appointment, health_expert_id: expert_id, date_time: NaiveDateTime.new!(day, start_time))) != nil do
        [Time.truncate(start_time, :second) | acc]
      else
        acc
    end
    start_time = Time.add(start_time, 1800, :second)
    calculate_slots_day(expert_id, day, start_time, end_time, acc)
  end
  def calculate_slots_day(_, _, _, _, acc) do
    acc
  end 
  
  def calculate_slots_in_range(expert_id, start_day, end_day, acc) when start_day <= end_day do
    acc = Map.put(acc, start_day, get_slots_day(expert_id, start_day))
    start_day = Date.add(start_day, 1)
    calculate_slots_in_range(expert_id, start_day, end_day, acc)
  end
  def calculate_slots_in_range(_, _, _, acc) do
    acc
  end

  def available_slots(expert_id, from_date, to_date) do
    if Date.compare(from_date, to_date) == :gt do
      {:error, "wrong date range"}
    else 
      calculate_slots_in_range(expert_id, from_date, to_date, %{})
    end
  end

  def new_appointment(expert_id, pet_id, appointment_date_time) do
    cond do
      NaiveDateTime.compare(appointment_date_time, NaiveDateTime.local_now()) == :lt ->
        {:error, "datetime is in the past"}

      !(Repo.exists?(from p in Pet, where: p.id == ^pet_id)) ->
        {:error, "pet with id = #{pet_id} doesn't exist"}
      
      !(Repo.exists?(from h in HealthExpert, where: h.id == ^expert_id)) ->
        {:error, "expert with id = #{expert_id} doesn't exist"}

      Enum.member?(get_slots_day(expert_id, NaiveDateTime.to_date(appointment_date_time)), Time.truncate(NaiveDateTime.to_time(appointment_date_time), :second)) ->
        appointment = %Appointment{date_time: NaiveDateTime.truncate(appointment_date_time, :second), pet_id: pet_id, health_expert_id: expert_id}
        Repo.insert(appointment)
      true ->
        {:error, "unavailable time slot"}
      
    end
  end
end
