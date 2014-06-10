class Page < ActiveRecord::Base
  has_many :content_blocks, as: :page
  accepts_nested_attributes_for :content_blocks, allow_destroy: true
end
