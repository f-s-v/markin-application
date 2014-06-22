require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "valid set" do
    assert orders(:empty).valid?
    assert orders(:us_customer).valid?
  end

  test "validates public_id" do
    order = orders(:empty)
    order.public_id = nil
    assert order.invalid?
  end

  test ".ready_to_checkout?" do
    assert_not orders(:empty).ready_to_checkout?
    assert_not orders(:us_customer).ready_to_checkout?

    orders(:us_customer).items << order_items(:one).dup
    assert orders(:us_customer).ready_to_checkout?
  end

  test ".delivery_price" do
    assert_equal orders(:empty).delivery_price, 0
    assert_equal orders(:us_customer).delivery_price, order_delivery_zones(:us).delivery_price
    assert_equal orders(:fr_customer).delivery_price, order_delivery_zones(:fr).delivery_price
  end

  test ".subtotal" do
    order = orders(:us_customer)
    order.items << order_items(:one).dup
    order.items << order_items(:two).dup
    assert_equal order.subtotal, order.items.map{|i| i.amount * i.price}.sum
  end

  test ".total" do
    order = orders(:empty)
    order.items << order_items(:one).dup
    order.items << order_items(:two).dup
    assert_equal order.total, order.subtotal + order.delivery_price
  end
end
