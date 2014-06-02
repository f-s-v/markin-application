require 'test_helper'

class CartFlowTest < ActionDispatch::IntegrationTest
  include CapybaraHelper

  test "add products to cart" do
    visit store_product_path(products(:one))
    assert_difference 'current_order.items.count' do
      find('[data-label~=store-add-to-cart]').click
    end
  end

  test "view cart" do
    add_to_cart(products(:one))
    find('[data-label~=store-open-current-order]').click
    assert_equal page.status_code, 200
  end

  test "edit cart" do
    add_to_cart(products(:one))
    visit store_order_path
    find('[data-label~=store-order-edit]').click
    assert_equal page.status_code, 200
  end

  test "update contact info" do
    add_to_cart(products(:one))
    visit edit_store_order_path
    assert current_order.ready_to_checkout?
    assert current_order.invalid?
    fill_order(orders(:valid))
    find('[name=commit]').click
    current_order!
    assert current_order.ready_to_checkout?
    assert current_order.valid?
  end

  test "delete order items" do
    add_to_cart(products(:one))
    add_to_cart(products(:two))
    visit edit_store_order_path
    fill_order(orders(:valid))
    check("order_items_attributes_0__destroy")
    assert_difference "current_order.items.count", -1 do
      find('[name=commit]').click
    end
  end

  test "delete order" do
    add_to_cart(products(:one))
    visit store_order_path
    old_order_id = current_order.public_id
    find('[data-label~=store-order-delete]').click
    add_to_cart(products(:one))
    assert_not current_order!.public_id == old_order_id
  end
end
