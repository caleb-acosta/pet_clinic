defmodule PetClinic.PetHealthExpertTest do
  use PetClinic.DataCase

  alias PetClinic.PetHealthExpert

  describe "health_experts" do
    alias PetClinic.PetHealthExpert.HealthExpert

    import PetClinic.PetHealthExpertFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

    test "list_health_experts/0 returns all health_experts" do
      health_expert = health_expert_fixture()
      assert PetHealthExpert.list_health_experts() == [health_expert]
    end

    test "get_health_expert!/1 returns the health_expert with given id" do
      health_expert = health_expert_fixture()
      assert PetHealthExpert.get_health_expert!(health_expert.id) == health_expert
    end

    test "create_health_expert/1 with valid data creates a health_expert" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", sex: "some sex", specialities: "some specialities"}

      assert {:ok, %HealthExpert{} = health_expert} = PetHealthExpert.create_health_expert(valid_attrs)
      assert health_expert.age == 42
      assert health_expert.email == "some email"
      assert health_expert.name == "some name"
      assert health_expert.sex == "some sex"
      assert health_expert.specialities == "some specialities"
    end

    test "create_health_expert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.create_health_expert(@invalid_attrs)
    end

    test "update_health_expert/2 with valid data updates the health_expert" do
      health_expert = health_expert_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", sex: "some updated sex", specialities: "some updated specialities"}

      assert {:ok, %HealthExpert{} = health_expert} = PetHealthExpert.update_health_expert(health_expert, update_attrs)
      assert health_expert.age == 43
      assert health_expert.email == "some updated email"
      assert health_expert.name == "some updated name"
      assert health_expert.sex == "some updated sex"
      assert health_expert.specialities == "some updated specialities"
    end

    test "update_health_expert/2 with invalid data returns error changeset" do
      health_expert = health_expert_fixture()
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.update_health_expert(health_expert, @invalid_attrs)
      assert health_expert == PetHealthExpert.get_health_expert!(health_expert.id)
    end

    test "delete_health_expert/1 deletes the health_expert" do
      health_expert = health_expert_fixture()
      assert {:ok, %HealthExpert{}} = PetHealthExpert.delete_health_expert(health_expert)
      assert_raise Ecto.NoResultsError, fn -> PetHealthExpert.get_health_expert!(health_expert.id) end
    end

    test "change_health_expert/1 returns a health_expert changeset" do
      health_expert = health_expert_fixture()
      assert %Ecto.Changeset{} = PetHealthExpert.change_health_expert(health_expert)
    end
  end
end
