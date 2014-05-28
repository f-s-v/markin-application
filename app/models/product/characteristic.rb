class Product::Characteristic < ActiveRecord::Base
  has_many :options, class_name: 'Product::Characteristic::Option'
  accepts_nested_attributes_for :options, allow_destroy: true
end
