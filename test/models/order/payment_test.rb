require 'test_helper'

class Order::PaymentTest < ActiveSupport::TestCase
  setup do
    orders(:valid).items << order_items(:one).dup
    orders(:valid).items << order_items(:two).dup
    @payment = Order::Payment.create_for_order(orders(:valid), '127.0.0.1')
  end

  test 'payment_details in memory caching' do
    assert_no_difference '@payment.payment_details.object_id' do
      @payment.payment_details
    end
  end

  test 'self.create_for_order' do
    assert @payment.valid?
    assert @payment.payment_details.success?
    assert_equal @payment.state, 'initial'
    assert_equal @payment.payment_token, @payment.payment_details.token
    assert_equal @payment.payer_ip, '127.0.0.1'
    assert_equal @payment.order_id, orders(:valid).id
    assert_equal @payment.payment_details.details['PaymentDetailsItem'], orders(:valid).items.map{|i|
      {
        "Name" => i.product.name,
        "Quantity" => i.amount.to_s,
        "Tax" => '0.00',
        "Amount" => i.price.to_s,
        "EbayItemPaymentDetailsItem" => nil,
        # fill options fixtures for next line
        # "Description" => i.product.options_description
      }
    }.to_a
  end
end