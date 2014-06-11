class ContentBlock < ActiveRecord::Base
  belongs_to :page, polymorphic: true

  scope :ordered, -> {order('order_number')}
end
