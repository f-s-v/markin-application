require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create order instance before ordering" do
    assert orders(:empty).valid?
    assert orders(:empty_authorized).valid?
  end

  test "calculate total" do
    order = orders(:empty)
    order.items << order_items(:one).dup
    order.items << order_items(:two).dup
    assert_equal order.total, order.items.map{|i| i.amount * i.price}.sum
  end

  test "checkout without items" do
    skip
  end

  test "checkout with items" do
    skip
  end

  test "receive payment" do
    skip
  end

  test "cancel order" do
    skip
  end

end
