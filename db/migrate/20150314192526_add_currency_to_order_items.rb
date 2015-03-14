class AddCurrencyToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :currency, :string, default: 'USD'
    Order::Item.reset_column_information
    Order::Item.update_all(currency: 'USD')
  end
end
