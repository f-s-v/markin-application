class CountriesOrderDeliveryZones < ActiveRecord::Migration
  def change
    create_table :countries_order_delivery_zones, id: false do |t|
      t.references :country, index: true
      t.references :delivery_zone, index: true

      t.timestamps
    end

  end
end
