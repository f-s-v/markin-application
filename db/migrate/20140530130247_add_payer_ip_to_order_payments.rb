class AddPayerIpToOrderPayments < ActiveRecord::Migration
  def change
    add_column :order_payments, :payer_ip, :string
  end
end
