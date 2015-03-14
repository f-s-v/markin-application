class Product < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Translated
  translated :name, :description

  include Concerns::ContentBlocks
  include Concerns::Recent

  belongs_to :batch
  has_and_belongs_to_many :options, class_name: 'Product::Characteristic::Option'
  # has_and_belongs_to_many :sizes, class_name: 'Product::Size'
  validates :name, :price, :poster, :batch, presence: true

  def to_param
    public_id
  end

  def price_with_currency(locale)
    if (locale == :ru) && converted_price
      [price_rub.present? ? price_rub : converted_price, :RUB, :ru]
    else
      [price, :USD, :en]
    end
  end

  def converted_price
    if mult = ::Setting.usd_rub
      price * mult
    end
  end

  def price_by_locale(locale = I18n.locale)
    price_with_currency(locale).first
  end
end
