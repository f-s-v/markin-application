module CapybaraHelper
  def sign_out
    if all('#sessionSignOut').present?
      click_on('sessionSignOut')
    end
  end

  def sign_in(user)
    # visit new_user_session_path
    if current_path == new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'user123'
      check('user_remember_me')
      find('input[name~=commit]').click
    end
  end

  def fill_order(fixture)
    select(fixture.country.name, from: "order_country_id")
    %w(shipping_address_line1 shipping_address_line2 shipping_city
      shipping_state shipping_zip phone_number).each do |field|
      fill_in "order_#{field}", with: fixture.send(field)
    end
  end

  def add_to_cart(product, amount = 1)
    visit store_product_path(product)
    fill_in "order_item_amount", with: amount
    find('[data-label~=store-add-to-cart]').click
  end

  def checkout(user, order, *products)
    products.each do |product|
      add_to_cart(product)
      visit edit_store_order_path
      fill_order(order)
      find('[name=commit]').click
    end
    visit new_store_order_payment_path
    sign_in(user)
  end
end
