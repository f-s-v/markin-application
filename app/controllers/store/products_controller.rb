class Store::ProductsController < Store::BaseController
  inherit_resources
  defaults finder: :find_by_public_id!
end
