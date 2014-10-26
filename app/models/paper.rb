class Paper < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Translated
  translated :title, :description

  include Concerns::ContentBlocks
  
  default_value_for :published_at, -> { Time.zone.now }
  
  validates :poster, :published_at, presence: true
  
  scope :recent, -> { order('published_at desc') }
  scope :published, -> { where('published_at < ?', Time.zone.now) }
  
  def to_param
    public_id
  end
end
