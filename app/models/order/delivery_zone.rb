class Order::DeliveryZone < ActiveRecord::Base
  has_and_belongs_to_many :countries

  validates :name, :delivery_price, presence: true
end
