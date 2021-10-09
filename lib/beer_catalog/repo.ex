defmodule BeerCatalog.Repo do
  use Ecto.Repo,
    otp_app: :beer_catalog,
    adapter: Ecto.Adapters.MyXQL
end
