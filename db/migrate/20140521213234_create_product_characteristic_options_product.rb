class CreateProductCharacteristicOptionsProduct < ActiveRecord::Migration
  def change
    create_table :product_characteristic_options_products, id: false do |t|
      t.references :product
      t.references :option
    end
  end
end
