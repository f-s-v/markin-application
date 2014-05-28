class Store::CartsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, only: 'checkout'

  def receive
  end

  def checkout
    cart.update_attributes user: current_user
    purchase = PAYMENT_GATEWAY.setup_purchase(
      cart.total * 100,
      ip: request.remote_ip,
      order_id: cart.id,
      return_url: new_store_cart_payment_url,
      cancel_return_url: cancel_checkout_store_cart_url,
      currency: "USD",
      allow_guest_checkout: true,
      email: cart.user.email,
      no_shipping: true,
      
      shipping_address: {
        country: 'US',
        name: 'First Last',
        address1: 'address1',
        address2: 'address2',
        phone: '555-555-1234',
        city: 'Los Angeles',
        state: 'LA',
        zip: '90001',
      },
      items: cart.items.map{|i|
        {
          name: i.product.name,
          description: i.product.name,
          quantity: i.amount,
          amount: i.price * 100
        }
      }
    )
    redirect_to PAYMENT_GATEWAY.redirect_url_for(purchase.token)
  end
end
