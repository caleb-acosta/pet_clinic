defmodule PetClinic.ExpertSchedulesTest do
  use PetClinic.DataCase

  alias PetClinic.ExpertSchedules

  describe "expert_schedules" do
    alias PetClinic.ExpertSchedules.ExpertSchedule

    import PetClinic.ExpertSchedulesFixtures

    @invalid_attrs %{day: nil, from_hour: nil, health_expert_id: nil, to_hour: nil}

    test "list_expert_schedules/0 returns all expert_schedules" do
      expert_schedule = expert_schedule_fixture()
      assert ExpertSchedules.list_expert_schedules() == [expert_schedule]
    end

    test "get_expert_schedule!/1 returns the expert_schedule with given id" do
      expert_schedule = expert_schedule_fixture()
      assert ExpertSchedules.get_expert_schedule!(expert_schedule.id) == expert_schedule
    end

    test "create_expert_schedule/1 with valid data creates a expert_schedule" do
      valid_attrs = %{day: "some day", from_hour: ~T[14:00:00], health_expert_id: 42, to_hour: ~T[14:00:00]}

      assert {:ok, %ExpertSchedule{} = expert_schedule} = ExpertSchedules.create_expert_schedule(valid_attrs)
      assert expert_schedule.day == "some day"
      assert expert_schedule.from_hour == ~T[14:00:00]
      assert expert_schedule.health_expert_id == 42
      assert expert_schedule.to_hour == ~T[14:00:00]
    end

    test "create_expert_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExpertSchedules.create_expert_schedule(@invalid_attrs)
    end

    test "update_expert_schedule/2 with valid data updates the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      update_attrs = %{day: "some updated day", from_hour: ~T[15:01:01], health_expert_id: 43, to_hour: ~T[15:01:01]}

      assert {:ok, %ExpertSchedule{} = expert_schedule} = ExpertSchedules.update_expert_schedule(expert_schedule, update_attrs)
      assert expert_schedule.day == "some updated day"
      assert expert_schedule.from_hour == ~T[15:01:01]
      assert expert_schedule.health_expert_id == 43
      assert expert_schedule.to_hour == ~T[15:01:01]
    end

    test "update_expert_schedule/2 with invalid data returns error changeset" do
      expert_schedule = expert_schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = ExpertSchedules.update_expert_schedule(expert_schedule, @invalid_attrs)
      assert expert_schedule == ExpertSchedules.get_expert_schedule!(expert_schedule.id)
    end

    test "delete_expert_schedule/1 deletes the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      assert {:ok, %ExpertSchedule{}} = ExpertSchedules.delete_expert_schedule(expert_schedule)
      assert_raise Ecto.NoResultsError, fn -> ExpertSchedules.get_expert_schedule!(expert_schedule.id) end
    end

    test "change_expert_schedule/1 returns a expert_schedule changeset" do
      expert_schedule = expert_schedule_fixture()
      assert %Ecto.Changeset{} = ExpertSchedules.change_expert_schedule(expert_schedule)
    end
  end
end
