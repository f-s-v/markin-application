module StoreTestHelper
  def current_order(reload = true)
    if reload
      @current_order = Order.where(public_id: session["order_id"]).first
    else
      @current_order ||= Order.where(public_id: session["order_id"]).first
    end
  end

  def register_current_order
    get store_batch_product_url(products(:one).batch, products(:one))
    assert session["order_id"].present?
  end

  def add_to_cart(product)
    post_via_redirect store_order_items_url, product_public_id: product.public_id
  end

  def fill_order_shipping_info_with(fixture)
    shipping_params = {
      country_id: fixture.country.id
    }

    %w(shipping_address_line1 shipping_address_line2
      shipping_city shipping_state shipping_zip
      phone_number shipping_name
    ).each do |field|
      shipping_params[field] = fixture.send(field)
    end

    post_via_redirect store_order_shipping_info_url, order_shipping_info: shipping_params
    current_order.reload
  end
end