class Order::ShippingInfo < ActiveRecord::Base
  belongs_to :order
  belongs_to :country

  validates :country,
    :phone_number,
    :shipping_address_line1,
    :shipping_city,
    :shipping_state,
    :shipping_zip,
    presence: true

end
