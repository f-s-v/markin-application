require 'test_helper'

class CartFlowTest < ActionDispatch::IntegrationTest
  setup do
    register_current_order
  end

  test "add products to cart" do
    assert_difference 'current_order.items.count' do
      add_to_cart(products(:one))
    end
  end

  test "view cart" do
    add_to_cart(products(:one))
    get store_order_url
    assert_equal status, 200
  end

  test "edit cart" do
    add_to_cart(products(:one))
    visit edit_store_order_url
    assert_equal status, 200
  end

  test "update contact info" do
    add_to_cart(products(:one))
    fill_order_shipping_info_with(orders(:us_customer).shipping_info)
    assert current_order.ready_to_checkout?
  end

  test "delete order items" do
    add_to_cart(products(:one))
    add_to_cart(products(:two))
    fill_order_shipping_info_with(orders(:us_customer).shipping_info)
    assert_difference "current_order.items.count", -1 do
      patch_via_redirect store_order_url, order: {
        items_attributes: [{id: current_order.items.last.id, _destroy: '1'}]
      }
    end
  end

  test "delete order" do
    add_to_cart(products(:one))
    old_order_id = current_order.public_id
    delete_via_redirect store_order_url
    
    add_to_cart(products(:one))
    assert_not current_order(true).public_id == old_order_id
  end
end
