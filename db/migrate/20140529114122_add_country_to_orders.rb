class AddCountryToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :country, index: true
  end
end
