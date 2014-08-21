class Translation < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  validates :owner_type, :owner_id, :key, :locale, presence: true
end
