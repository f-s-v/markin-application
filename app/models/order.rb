class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: 'Order::Item'

  def total
    items.sum("order_items.price * order_items.amount")
  end
end
