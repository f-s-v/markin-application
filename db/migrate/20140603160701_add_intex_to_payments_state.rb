class AddIntexToPaymentsState < ActiveRecord::Migration
  def change
    add_index :order_payments, :state
  end
end
