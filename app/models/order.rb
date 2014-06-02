class Order < ActiveRecord::Base
  include ::PublicId
  generates_public_id :public_id

  belongs_to :user
  belongs_to :country
  has_many :items, class_name: 'Order::Item', dependent: :destroy
  has_many :payments, class_name: 'Order::Payment', dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :public_id, presence: true

  validates :country_id,
    :phone_number,
    :shipping_address_line1,
    :shipping_city,
    :shipping_state,
    :shipping_zip,
    presence: true,
    if: :ready_to_checkout?

  def total
    items.sum("order_items.price * order_items.amount")
  end

  def ready_to_checkout?
    items.size > 0
  end

  def to_param
    public_id.to_s
  end
end
