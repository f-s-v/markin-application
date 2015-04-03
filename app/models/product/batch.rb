class Product::Batch < ActiveRecord::Base
  include Concerns::Translated
  translated :name, :description

  include Concerns::ContentBlocks
  include Concerns::DirectAccess

  include Concerns::PublicId
  generates_public_id :public_id
  
  has_many :products

  def to_s
    name.value
  end
  
  def to_param
    public_id
  end
end
