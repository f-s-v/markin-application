class Order < ActiveRecord::Base
  include Concerns::Messaging

  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Recent

  belongs_to :user
  belongs_to :country
  has_many :items, class_name: 'Order::Item', dependent: :destroy
  has_many :payments, class_name: 'Order::Payment', dependent: :destroy
  has_one :shipping_info, class_name: 'Order::ShippingInfo', dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true
  accepts_nested_attributes_for :shipping_info

  validates :public_id, presence: true

  scope :completed, -> { joins(:payments).where('order_payments.state' => ['paid', 'refunded']) }
  scope :with_user, -> { where('user_id is not null') }

  def delivery_price
    zone = shipping_info && Order::DeliveryZone.joins(:countries).where('countries.id' => shipping_info.country_id).first
    if zone
      zone.delivery_price
    else
      0.0
    end
  end

  def subtotal
    items.sum("order_items.price * order_items.amount")
  end

  def total
     subtotal + delivery_price
  end

  def ready_to_checkout?
    items.size > 0 && shipping_info.present?
  end

  def to_param
    public_id.to_s
  end
  
  def sent
    send_message :sent
  end
end
