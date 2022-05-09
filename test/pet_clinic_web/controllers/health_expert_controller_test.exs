defmodule PetClinicWeb.HealthExpertControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetHealthExpertFixtures

  @create_attrs %{
    age: 42,
    email: "some email",
    name: "some name",
    sex: "some sex",
    specialities: "some specialities"
  }
  @update_attrs %{
    age: 43,
    email: "some updated email",
    name: "some updated name",
    sex: "some updated sex",
    specialities: "some updated specialities"
  }
  @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

  describe "index" do
    test "lists all health_experts", %{conn: conn} do
      conn = get(conn, Routes.health_expert_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Health experts"
    end
  end

  describe "new health_expert" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.health_expert_path(conn, :new))
      assert html_response(conn, 200) =~ "New Health expert"
    end
  end

  describe "create health_expert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.health_expert_path(conn, :create), health_expert: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.health_expert_path(conn, :show, id)

      conn = get(conn, Routes.health_expert_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Health expert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.health_expert_path(conn, :create), health_expert: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Health expert"
    end
  end

  describe "edit health_expert" do
    setup [:create_health_expert]

    test "renders form for editing chosen health_expert", %{
      conn: conn,
      health_expert: health_expert
    } do
      conn = get(conn, Routes.health_expert_path(conn, :edit, health_expert))
      assert html_response(conn, 200) =~ "Edit Health expert"
    end
  end

  describe "update health_expert" do
    setup [:create_health_expert]

    test "redirects when data is valid", %{conn: conn, health_expert: health_expert} do
      conn =
        put(conn, Routes.health_expert_path(conn, :update, health_expert),
          health_expert: @update_attrs
        )

      assert redirected_to(conn) == Routes.health_expert_path(conn, :show, health_expert)

      conn = get(conn, Routes.health_expert_path(conn, :show, health_expert))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, health_expert: health_expert} do
      conn =
        put(conn, Routes.health_expert_path(conn, :update, health_expert),
          health_expert: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Health expert"
    end
  end

  describe "delete health_expert" do
    setup [:create_health_expert]

    test "deletes chosen health_expert", %{conn: conn, health_expert: health_expert} do
      conn = delete(conn, Routes.health_expert_path(conn, :delete, health_expert))
      assert redirected_to(conn) == Routes.health_expert_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.health_expert_path(conn, :show, health_expert))
      end
    end
  end

  defp create_health_expert(_) do
    health_expert = health_expert_fixture()
    %{health_expert: health_expert}
  end
end
