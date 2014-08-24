class Product::Batch < ActiveRecord::Base
  include Concerns::Translated
  translated :name

  def to_s
    name.value
  end
end
