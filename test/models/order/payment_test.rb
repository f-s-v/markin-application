require 'test_helper'

class Order::PaymentTest < ActiveSupport::TestCase
  setup do
    @order = orders(:us_customer)
    @order.items << order_items(:one).dup
    @order.items << order_items(:two).dup
    @payment = Order::Payment.create_for_order(@order, '127.0.0.1')
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
    assert_equal @payment.order_id, @order.id
    assert_equal @payment.payment_details.details["OrderTotal"], @order.total.to_s
    assert_equal @payment.payment_details.details["ItemTotal"], @order.subtotal.to_s
    assert_equal @payment.payment_details.details["ShippingTotal"], @order.delivery_price.to_s
    assert_equal @payment.payment_details.details["HandlingTotal"], "0.00"
    assert_equal @payment.payment_details.details["TaxTotal"], "0.00"
    assert_equal @payment.payment_details.details["InvoiceID"], @order.public_id
  end
end