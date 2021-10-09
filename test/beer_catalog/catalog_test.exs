defmodule BeerCatalog.CatalogTest do
  use BeerCatalog.DataCase

  alias BeerCatalog.Catalog

  describe "beers" do
    alias BeerCatalog.Catalog.Beer

    import BeerCatalog.CatalogFixtures

    @invalid_attrs %{brand: nil, origin: nil, quantity: nil, style: nil}

    test "list_beers/0 returns all beers" do
      beer = beer_fixture()
      assert Catalog.list_beers() == [beer]
    end

    test "get_beer!/1 returns the beer with given id" do
      beer = beer_fixture()
      assert Catalog.get_beer!(beer.id) == beer
    end

    test "create_beer/1 with valid data creates a beer" do
      valid_attrs = %{brand: "some brand", origin: "some origin", quantity: 42, style: "some style"}

      assert {:ok, %Beer{} = beer} = Catalog.create_beer(valid_attrs)
      assert beer.brand == "some brand"
      assert beer.origin == "some origin"
      assert beer.quantity == 42
      assert beer.style == "some style"
    end

    test "create_beer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_beer(@invalid_attrs)
    end

    test "update_beer/2 with valid data updates the beer" do
      beer = beer_fixture()
      update_attrs = %{brand: "some updated brand", origin: "some updated origin", quantity: 43, style: "some updated style"}

      assert {:ok, %Beer{} = beer} = Catalog.update_beer(beer, update_attrs)
      assert beer.brand == "some updated brand"
      assert beer.origin == "some updated origin"
      assert beer.quantity == 43
      assert beer.style == "some updated style"
    end

    test "update_beer/2 with invalid data returns error changeset" do
      beer = beer_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_beer(beer, @invalid_attrs)
      assert beer == Catalog.get_beer!(beer.id)
    end

    test "delete_beer/1 deletes the beer" do
      beer = beer_fixture()
      assert {:ok, %Beer{}} = Catalog.delete_beer(beer)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_beer!(beer.id) end
    end

    test "change_beer/1 returns a beer changeset" do
      beer = beer_fixture()
      assert %Ecto.Changeset{} = Catalog.change_beer(beer)
    end
  end
end
