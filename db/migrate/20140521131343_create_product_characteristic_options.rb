class CreateProductCharacteristicOptions < ActiveRecord::Migration
  def change
    create_table :product_characteristic_options do |t|
      t.references :characteristic, index: true
      t.string :name

      t.timestamps
    end
  end
end
