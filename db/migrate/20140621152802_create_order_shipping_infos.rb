class CreateOrderShippingInfos < ActiveRecord::Migration
  def change
    create_table :order_shipping_infos do |t|
      t.references :order, index: true, unique: true
      t.references :country, index: true
      t.string :shipping_address_line1
      t.string :shipping_address_line2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :phone_number

      t.timestamps
    end

    Order.find_each do |order|
      shipping_info = order.build_shipping_info
      shipping_info.country = order.country
      shipping_info.shipping_address_line1 = order.shipping_address_line1
      shipping_info.shipping_address_line2 = order.shipping_address_line2
      shipping_info.shipping_city = order.shipping_city
      shipping_info.shipping_state = order.shipping_state
      shipping_info.shipping_zip = order.shipping_zip
      shipping_info.phone_number = order.phone_number
      shipping_info.save
    end

    remove_column :orders, :country_id
    remove_column :orders, :shipping_address_line1
    remove_column :orders, :shipping_address_line2
    remove_column :orders, :shipping_city
    remove_column :orders, :shipping_state
    remove_column :orders, :shipping_zip
    remove_column :orders, :phone_number
  end
end
