class Product::Characteristic::Option < ActiveRecord::Base
  include Concerns::Translated
  translated :name

  belongs_to :characteristic

  def to_s
    name.value
  end
end
