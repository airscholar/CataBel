defmodule BeerCatalog.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BeerCatalog.Catalog` context.
  """

  @doc """
  Generate a beer.
  """
  def beer_fixture(attrs \\ %{}) do
    {:ok, beer} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        origin: "some origin",
        quantity: 42,
        style: "some style"
      })
      |> BeerCatalog.Catalog.create_beer()

    beer
  end
end
