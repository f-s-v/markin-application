class Order::Item < ActiveRecord::Base
  DEFAULT_AMOUNT = 1
  default_value_for :amount, DEFAULT_AMOUNT

  belongs_to :order
  belongs_to :product

  validates :product, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  # validates :size, presence: true, if: :product_has_sizes
  before_validation :set_price, on: :create

  default_scope -> { order('created_at desc') }

  def total
    amount * price
  end

  def product_public_id=(val)
    self.product_id = Product.where(public_id: val).first!.id
  end

  def product_public_id
    product && product.public_id
  end

  protected def set_price
    self.price = product.price
  end

  protected def product_has_sizes
    product && product.has_sizes
  end
end
