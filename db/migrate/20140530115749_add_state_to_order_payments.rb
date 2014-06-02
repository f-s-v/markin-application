class AddStateToOrderPayments < ActiveRecord::Migration
  def change
    add_column :order_payments, :state, :string, index: true
  end
end
