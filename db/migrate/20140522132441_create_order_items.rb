class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :amount
      t.references :order, index: true
      t.decimal :price
      t.references :product, index: true

      t.timestamps
    end
  end
end
