class AddPriceOptionsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price_by_request, :boolean, default: false
    add_column :products, :price_rub, :decimal
    Product.update_all(price_by_request: false)
  end
end
