class Paper < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Translated
  translated :title, :description

  include Concerns::ContentBlocks
  include Concerns::Recent
  
  default_scope -> {order('created_at desc')}
  
  validates :poster, presence: true
  
  def to_param
    public_id
  end
end
