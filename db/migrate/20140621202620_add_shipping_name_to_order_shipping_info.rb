class AddShippingNameToOrderShippingInfo < ActiveRecord::Migration
  def change
    add_column :order_shipping_infos, :shipping_name, :string
  end
end
