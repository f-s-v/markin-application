require 'test_helper'

class Order::ItemTest < ActiveSupport::TestCase
  test "validates product presence" do
    item = order_items(:one)
    assert item.valid?
    item.product = nil
    assert item.invalid?
  end

  test "set price to product price on create" do
    item = Order::Item.create(order_items(:one).attributes.except("id", "price"))
    assert_equal item.price, item.product.price
  end

  test 'default amount' do
    item = Order::Item.create(order_items(:one).attributes.except("id", "amount"))
    assert_equal item.amount, Order::Item::DEFAULT_AMOUNT
  end
end
