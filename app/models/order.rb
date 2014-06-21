class Order < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Recent

  belongs_to :user
  belongs_to :country
  has_many :items, class_name: 'Order::Item', dependent: :destroy
  has_many :payments, class_name: 'Order::Payment', dependent: :destroy
  has_one :shipping_info, class_name: 'Order::ShippingInfo', dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :public_id, presence: true

  scope :completed, -> { joins(:payments).where('order_payments.state' => 'paid') }
  scope :with_user, -> { where('user_id is not null') }

  def total
    items.sum("order_items.price * order_items.amount")
  end

  def ready_to_checkout?
    items.size > 0 && shipping_info.present?
  end

  def to_param
    public_id.to_s
  end
end
