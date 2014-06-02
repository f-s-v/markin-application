class CreateOrderPayments < ActiveRecord::Migration
  def change
    create_table :order_payments do |t|
      t.references :order, index: true
      t.string :payment_token
      t.string :payer_token
      t.timestamps
    end
  end
end
