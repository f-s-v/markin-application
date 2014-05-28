require 'test_helper'

class CartFlowTest < ActionDispatch::IntegrationTest
  test "add to cart as unauthorized" do
    visit store_product_path(products(:one))
    assert_difference 'Order.last.items.count' do
      click_on 'Add to cart'
    end
  end

  test "view cart" do
    [:one, :two].each do |name|
      visit store_product_path(products(name))
      click_on 'Add to cart'
    end
    
    visit store_cart_path
    within 'ul.store-cart-items' do
      [:one, :two].each do |name|
        item = Order.last.items.where(product: products(name)).first
        assert page.has_link? nil, href: store_product_path(products(name))
        assert page.has_link? nil, href: store_cart_item_path(item)
      end
    end
  end

  test 'delete item from cart' do
    visit store_product_path(products(:one))
    click_on 'Add to cart'
    assert_difference 'Order.last.items.count', -1 do
      visit store_cart_path
      # binding.pry
      click_on "Delete from cart"
    end
  end

  test 'change cart item amount' do
    visit store_product_path(products(:one))
    click_on 'Add to cart'
    visit store_cart_path

    assert_difference "find('[data-label~=cart-item-amount]').text.to_i" do
      find('[data-label~="cart-item-increase"]').click
    end

    assert_difference "find('[data-label~=cart-item-amount]').text.to_i", -1 do
      find('[data-label~="cart-item-decrease"]').click
    end
  end

  test 'cart item amount validation' do
    visit store_product_path(products(:one))
    click_on 'Add to cart'
    visit store_cart_path

    assert_equal find('[data-label~=cart-item-amount]').text.to_i, 1

    assert_no_difference "find('[data-label~=cart-item-amount]').text.to_i" do
      find('[data-label~="cart-item-decrease"]').click
    end
  end
end
