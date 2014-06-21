class AddNameToOrderDeliveryZone < ActiveRecord::Migration
  def change
    add_column :order_delivery_zones, :name, :string
  end
end
