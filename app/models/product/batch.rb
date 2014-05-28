class Product::Batch < ActiveRecord::Base
  validates :name, presence: true
end
