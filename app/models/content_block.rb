class ContentBlock < ActiveRecord::Base
  include Concerns::Translated
  translated :text

  belongs_to :page, polymorphic: true

  scope :ordered, -> {order('order_number')}
end
