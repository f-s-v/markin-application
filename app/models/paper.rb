class Paper < ActiveRecord::Base
  include Concerns::PublicId
  generates_public_id :public_id

  include Concerns::Translated
  translated :title

  include Concerns::ContentBlocks
  
  default_scope -> {order('created_at desc')}
  
  def to_param
    public_id
  end
end
