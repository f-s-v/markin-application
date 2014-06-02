class AddShippingInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address_line1, :string
    add_column :orders, :shipping_address_line2, :string
    add_column :orders, :shipping_city, :string
    add_column :orders, :shipping_state, :string
    add_column :orders, :shipping_zip, :string

    add_column :orders, :phone_number, :string
  end
end
