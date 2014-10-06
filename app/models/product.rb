class Product < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Translated
  translated :name, :description

  include Concerns::ContentBlocks

  belongs_to :batch
  has_and_belongs_to_many :options, class_name: 'Product::Characteristic::Option'
  # has_and_belongs_to_many :sizes, class_name: 'Product::Size'
  validates :name, :price, :poster, :batch, presence: true

  def to_param
    public_id
  end
end
