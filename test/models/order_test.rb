require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "validates public_id" do
    order = orders(:valid)
    order.public_id = nil
    assert_not order.save
  end

  test "ready_to_checkout?" do
    assert orders(:empty).valid?
    assert_equal orders(:empty).ready_to_checkout?, false

    orders(:valid).update_attributes shipping_address_line1: nil
    orders(:valid).items << order_items(:one).dup
    assert orders(:valid).ready_to_checkout?
    assert orders(:valid).invalid?
  end

  test "total" do
    order = orders(:empty)
    order.items << order_items(:one).dup
    order.items << order_items(:two).dup
    assert_equal order.total, order.items.map{|i| i.amount * i.price}.sum
  end

end
