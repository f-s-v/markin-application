class Product < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  belongs_to :batch
  has_and_belongs_to_many :options, class_name: 'Product::Characteristic::Option'
  has_and_belongs_to_many :sizes, class_name: 'Product::Size'
  has_many :content_blocks, as: :page

  accepts_nested_attributes_for :content_blocks, allow_destroy: true

  validates :name, :price, :poster, :batch, presence: true

  def to_param
    public_id
  end
end
