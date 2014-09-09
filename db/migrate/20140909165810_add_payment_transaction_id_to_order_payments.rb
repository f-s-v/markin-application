class AddPaymentTransactionIdToOrderPayments < ActiveRecord::Migration
  def change
    add_column :order_payments, :payment_transaction_id, :string
  end
end
