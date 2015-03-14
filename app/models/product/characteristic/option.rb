class Product::Characteristic::Option < ActiveRecord::Base
  include Concerns::Translated
  include Concerns::ContentBlocks

  translated :name

  belongs_to :characteristic
  has_and_belongs_to_many :products

  def to_s
    name.value
  end
end
