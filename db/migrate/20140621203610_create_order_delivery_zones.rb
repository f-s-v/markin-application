class CreateOrderDeliveryZones < ActiveRecord::Migration
  def change
    create_table :order_delivery_zones do |t|
      t.decimal :delivery_price

      t.timestamps
    end
  end
end
