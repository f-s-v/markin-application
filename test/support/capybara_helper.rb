module CapybaraHelper
  def sign_out
    visit users_profile_path
    if all('#sessionSignOut').present?
      click_on('sessionSignOut')
    end
  end

  def sign_in(user)
    # visit new_user_session_path
    if current_path == new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'user123'
      find('input[name~=commit]').click
    end
  end

  def fill_order_shipping_info(fixture)
    select(fixture.country.name, from: "order_shipping_info_country_id")
    %w(shipping_address_line1 shipping_address_line2 shipping_city
      shipping_state shipping_zip phone_number shipping_name).each do |field|
      fill_in "order_shipping_info_#{field}", with: fixture.send(field)
    end
  end

  def add_to_cart(product)
    visit store_product_path(product)
    click_on('storeItemAddToCart')
  end

  def checkout(user, order, *products)
    products.each do |product|
      add_to_cart(product)
      visit new_store_order_shipping_info_path
      fill_order_shipping_info(order.shipping_info)
      find('[name=commit]').click
    end
    visit new_store_order_payment_path
    sign_in(user)
  end
end
