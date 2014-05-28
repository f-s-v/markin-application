class Order::Item < ActiveRecord::Base
  DEFAULT_AMOUNT = 1
  default_value_for :amount, DEFAULT_AMOUNT

  belongs_to :order
  belongs_to :product

  validates :product, presence: true
  validates :amount, numericality: { greater_than: 0 }
  before_validation :set_price, on: :create

  protected def set_price
    self.price = product.price
  end
end
