class Order::Payment < ActiveRecord::Base

  class GatewayError < Exception
  end

  belongs_to :order

  def self.create_for_order(order, payer_ip)
    url_options = Rails.application.config.action_controller.default_url_options
    response = PAYMENT_GATEWAY.setup_purchase(
      order.total * 100,
      ip: payer_ip,
      order_id: order.public_id,
      return_url: Rails.application.routes.url_helpers.pay_store_order_payments_url(url_options),
      cancel_return_url: Rails.application.routes.url_helpers.cancel_store_order_payments_url(url_options),
      currency: 'USD',
      allow_guest_checkout: true,
      email: order.user.email,
      no_shipping: true,
      shipping_address: {
        name: order.user.name,
        address1: order.shipping_info.shipping_address_line1,
        address2: order.shipping_info.shipping_address_line2,
        city: order.shipping_info.shipping_city,
        state: order.shipping_info.shipping_state,
        zip: order.shipping_info.shipping_zip,
        country: order.shipping_info.country.code,
        phone: order.shipping_info.phone_number,
      },
      items: order.items.map do |i|
        {
          name: i.product.name,
          description: i.product.batch.name,
          quantity: i.amount,
          amount: i.price * 100
        }
      end
    )

    unless response.success?
      raise GatewayError, response.message
    end

    order.payments.create(
      payment_token: response.token,
      state: 'initial',
      payer_ip: payer_ip
    )
  end

  def payment_details
    @payment_details ||= PAYMENT_GATEWAY.details_for(payment_token)
  end

  def checkout_url
    PAYMENT_GATEWAY.redirect_url_for(payment_token)
  end

  def process
    self.payer_token = payment_details.payer_id
    response = PAYMENT_GATEWAY.purchase(
      order.total * 100,
      ip: payer_ip,
      token: payment_token,
      payer_id: payer_token
    )

    if response.success?
      self.state = 'paid'
    else
      self.state = 'failed'
    end
    save
  end
end
