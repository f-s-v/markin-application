class Product < ActiveRecord::Base
  belongs_to :batch
  has_and_belongs_to_many :options, class_name: 'Product::Characteristic::Option'
  validates :name, :price, :poster, :batch, presence: true
end
