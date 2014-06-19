class Product < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  belongs_to :batch
  has_and_belongs_to_many :options, class_name: 'Product::Characteristic::Option'
  has_and_belongs_to_many :sizes, class_name: 'Product::Size'
  has_many :content_blocks, as: :page

  accepts_nested_attributes_for :content_blocks, allow_destroy: true

  validates :name, :price, :poster, :batch, presence: true

  def options_description
    opts = options.includes(:characteristic).group_by(&:characteristic)
    opts.map do |c, o|
      [
        c.name, 
        o.map(&:name).join(', ').mb_chars.downcase
      ].join(': ') + '.'
    end.join(' ')
  end

  def to_param
    public_id
  end
end
