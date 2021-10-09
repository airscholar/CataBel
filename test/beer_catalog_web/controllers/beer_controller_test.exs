defmodule BeerCatalogWeb.BeerControllerTest do
  use BeerCatalogWeb.ConnCase

  import BeerCatalog.CatalogFixtures

  alias BeerCatalog.Catalog.Beer

  @create_attrs %{
    brand: "some brand",
    origin: "some origin",
    quantity: 42,
    style: "some style"
  }
  @update_attrs %{
    brand: "some updated brand",
    origin: "some updated origin",
    quantity: 43,
    style: "some updated style"
  }
  @invalid_attrs %{brand: nil, origin: nil, quantity: nil, style: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all beers", %{conn: conn} do
      conn = get(conn, Routes.beer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create beer" do
    test "renders beer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.beer_path(conn, :create), beer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.beer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "brand" => "some brand",
               "origin" => "some origin",
               "quantity" => 42,
               "style" => "some style"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.beer_path(conn, :create), beer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update beer" do
    setup [:create_beer]

    test "renders beer when data is valid", %{conn: conn, beer: %Beer{id: id} = beer} do
      conn = put(conn, Routes.beer_path(conn, :update, beer), beer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.beer_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "brand" => "some updated brand",
               "origin" => "some updated origin",
               "quantity" => 43,
               "style" => "some updated style"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, beer: beer} do
      conn = put(conn, Routes.beer_path(conn, :update, beer), beer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete beer" do
    setup [:create_beer]

    test "deletes chosen beer", %{conn: conn, beer: beer} do
      conn = delete(conn, Routes.beer_path(conn, :delete, beer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.beer_path(conn, :show, beer))
      end
    end
  end

  defp create_beer(_) do
    beer = beer_fixture()
    %{beer: beer}
  end
end
